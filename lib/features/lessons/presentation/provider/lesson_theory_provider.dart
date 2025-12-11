import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/lessons/presentation/state/lesson_theory_state.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/state/auth_state.dart';
import '../../data/repositories/lessons_repository.dart';

part 'lesson_theory_provider.g.dart';

@riverpod
class LessonTheory extends _$LessonTheory {
  late final LessonsRepository _repo;
  late final int _userId;

  @override
  Future<LessonTheoryState> build(int lessonId) async {
    final authState = ref.watch(authProvider);
    _userId = authState is Authenticated ? authState.user.id : -1;

    _repo = GetIt.I<LessonsRepository>();
    final lesson = await _repo.getLessonById(lessonId);
    final parts = lesson.theory.split('\n---\n');
    final savedIndex = _repo.getLessonPageIndex(_userId, lessonId);
    final isFinished = _repo.isLessonCompleted(_userId, lessonId) || parts.length == 1;

    return LessonTheoryState(
      parts: parts,
      index: savedIndex.clamp(0, parts.length - 1),
      finished: isFinished,
    );
  }

  void next() {
    final s = state.value!;
    final newIndex = s.index + 1;
    final finished = newIndex == s.parts.length - 1;

    _repo.saveLessonPageIndex(_userId, lessonId, newIndex);

    if (finished) {
      _repo.markLessonCompleted(_userId, lessonId);
    }

    state = AsyncValue.data(s.copyWith(
        index: newIndex,
        finished: finished
    ));
  }

  void previous() {
    final s = state.value!;
    if (s.index == 0) return;

    final newIndex = s.index - 1;
    _repo.saveLessonPageIndex(_userId, lessonId, newIndex);

    state = AsyncValue.data(s.copyWith(index: newIndex));
  }
}