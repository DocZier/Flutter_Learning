import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/lessons/data/model/test_model.dart';
import 'package:test_practic/features/lessons/presentation/state/test_state.dart';

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/state/auth_state.dart';
import '../../data/repositories/lessons_repository.dart';
import '../../data/repositories/test_repository.dart';

part 'test_provider.g.dart';

@riverpod
class LessonTest extends _$LessonTest {
  late final TestsRepository _repo;
  late final int _userId;

  @override
  Future<LessonTestState> build(int lessonId) async {
    final authState = ref.watch(authProvider);
    _userId = authState is Authenticated ? authState.user.id : -1;

    _repo = GetIt.I<TestsRepository>();
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

      final entities = await _repo.getQuestionsForLesson(lessonId, userId: _userId);
      final models = entities.map((entity) => TestModel(
        id: entity.id,
        lessonId: entity.lessonId,
        question: entity.question,
        options: entity.options,
        correctOptionIndex: entity.correctOptionIndex,
        shortTheory: entity.shortTheory,
        translation: entity.translation,
        nextReviewDate: entity.nextReviewDate,
      )).toList();

      if (models.isNotEmpty) {
        models.shuffle();
      }
      return models;
  }

  Future<void> selectOption(int answerIndex) async {
    final s = state.value!;
    final q = s.questions[s.index];
    final isCorrect = answerIndex == q.correctOptionIndex;

    _repo.addStat(s.userId, s.lessonId, correct: isCorrect);

    final updatedMistakes = List<int>.from(s.mistakes);
    if (!isCorrect) {
      updatedMistakes.add(s.index);
      _repo.addToReviewQueue(s.userId, s.lessonId, q.toEntity(), interval: 1);
    } else {
      _repo.updateReviewInterval(s.userId, q.id, true);
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
