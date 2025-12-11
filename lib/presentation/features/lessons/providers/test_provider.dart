import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/domain/usecases/lessons/add_test_stats_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/add_to_review_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_questions_for_lesson_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/update_review_interval_usecase.dart';
import 'package:test_practic/presentation/features/lessons/states/test_state.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';

part 'test_provider.g.dart';

@riverpod
class LessonTest extends _$LessonTest {
  late final GetQuestionsForLessonUseCase _getQuestionsForLessonUseCase;
  late final AddTestStatUseCase _addTestStatUseCase;
  late final AddToReviewUseCase _addToReviewQueueUseCase;
  late final UpdateReviewIntervalUseCase _updateReviewIntervalUseCase;
  late final int _userId;

  @override
  Future<LessonTestState> build(int lessonId) async {
    _getQuestionsForLessonUseCase = GetIt.I<GetQuestionsForLessonUseCase>();
    _addTestStatUseCase = GetIt.I<AddTestStatUseCase>();
    _addToReviewQueueUseCase = GetIt.I<AddToReviewUseCase>();
    _updateReviewIntervalUseCase = GetIt.I<UpdateReviewIntervalUseCase>();

    final authState = ref.watch(authProvider);
    _userId = authState is Authenticated ? authState.user.id : -1;

    final questions = await _loadQuestions(lessonId);

    return LessonTestState(
      lessonId: lessonId,
      questions: questions,
      index: 0,
      selectedOption: null,
      showCorrect: false,
      theory: null,
      translation: null,
      correct: false,
      mistakes: [],
      finished: questions.isEmpty,
      userId: _userId,
      successful: questions.isEmpty,
    );
  }

  Future<List<TestModel>> _loadQuestions(int lessonId) async {
    final models = await _getQuestionsForLessonUseCase.execute(
        lessonId,
        userId: _userId
    );
    if (models.isNotEmpty) {
      models.shuffle();
    }
    return models;
  }

  Future<void> selectOption(int answerIndex) async {
    final s = state.value!;
    final q = s.questions[s.index];
    final isCorrect = answerIndex == q.correctOptionIndex;

    _addTestStatUseCase.execute(s.userId, lessonId, correct: isCorrect);

    final updatedMistakes = List<int>.from(s.mistakes);
    if (!isCorrect) {
      updatedMistakes.add(s.index);
      _addToReviewQueueUseCase.execute(
          s.userId,
          lessonId,
          q,
          interval: 1
      );
    } else {
      _updateReviewIntervalUseCase.execute(s.userId, q.id, true);
    }

    state = AsyncValue.data(
      s.copyWith(
        selectedOption: answerIndex,
        showCorrect: true,
        correct: isCorrect,
        theory: q.shortTheory,
        translation: q.translation,
        mistakes: updatedMistakes,
      ),
    );
  }

  Future<void> next() async {
    final s = state.value!;
    final isLast = s.index + 1 >= s.questions.length;
    if (isLast) {
      final successRate = (s.questions.length - s.mistakes.length) / s.questions.length;
      final isSuccessful = successRate >= 0.8;
      state = AsyncValue.data(
        s.copyWith(finished: true, successful: isSuccessful),
      );
      return;
    }
    state = AsyncValue.data(
      s.copyWith(
        index: s.index + 1,
        selectedOption: null,
        showCorrect: false,
        theory: null,
        translation: null,
      ),
    );
  }
}
