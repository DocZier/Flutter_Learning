import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/lessons/data/model/test_model.dart';
import 'package:test_practic/features/lessons/presentation/state/test_state.dart';

import '../../data/repositories/test_repository.dart';

part 'test_provider.g.dart';

@riverpod
class LessonTest extends _$LessonTest {
  late final TestsRepository _repo;

  @override
  Future<LessonTestState> build(int lessonId) async {
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
      finished: false,
    );
  }

  Future<List<TestModel>> _loadQuestions(int lessonId) async {
    try {
      final entities = await _repo.getQuestionsForLesson(lessonId);
      final models = entities.map(TestModel.fromEntity).toList();
      models.shuffle();
      return models;
    } catch (_) {
      return [];
    }
  }
  Future<void> selectOption(int answerIndex) async {
    final s = state.value!;
    final q = s.questions[s.index];

    final isCorrect = answerIndex == q.correctOptionIndex;

    _repo.addStat(s.lessonId, correct: isCorrect);

    final updatedMistakes = List<int>.from(s.mistakes);

    if (!isCorrect) {
      updatedMistakes.add(s.index);
      _repo.addToRepeat(s.lessonId, q.toEntity());
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

  Future<void> dontKnow() async {
    final s = state.value!;
    final q = s.questions[s.index];
    _repo.addToRepeat(s.lessonId, q.toEntity());

    await next();
  }

  Future<void> next() async {
    final s = state.value!;

    final isLast = s.index + 1 >= s.questions.length;

    if (isLast) {
      _repo.clearRepeatQueue(s.lessonId);

      state = AsyncValue.data(
        s.copyWith(finished: true),
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
