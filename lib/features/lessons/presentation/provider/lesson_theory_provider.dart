import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/lessons/presentation/state/lesson_theory_state.dart';

import '../../data/model/lesson_model.dart';
import '../../data/repositories/lessons_repository.dart';

part 'lesson_theory_provider.g.dart';

@riverpod
class LessonTheory extends _$LessonTheory {
  late final LessonsRepository _repo;

  @override
  Future<LessonTheoryState> build(int lessonId) async {
    _repo = GetIt.I<LessonsRepository>();

    final lesson = await _repo.getLessonById(lessonId);

    final parts = lesson.theory.split('\n\n---\n\n');

    final savedIndex = _repo.getLessonPageIndex(lessonId);
    final isFinished = _repo.isLessonCompleted(lessonId);

    return LessonTheoryState(
      parts: parts,
      index: savedIndex.clamp(0, parts.length - 1),
      finished: isFinished,
    );
  }

  void next() {
    final s = state.value!;

    if (s.index + 1 >= s.parts.length - 1) {
      _repo.markLessonCompleted(lessonId);

      state = AsyncValue.data(
        s.copyWith(
          finished: true,
        ),
      );
      return;
    }

    final newIndex = s.index + 1;
    _repo.saveLessonPageIndex(lessonId, newIndex);

    state = AsyncValue.data(s.copyWith(index: newIndex));
  }

  void previous() {
    final s = state.value!;
    if (s.index == 0) return;

    final newIndex = s.index - 1;
    _repo.saveLessonPageIndex(lessonId, newIndex);

    state = AsyncValue.data(s.copyWith(index: newIndex));
  }
}

