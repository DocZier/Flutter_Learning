import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/lessons/get_lesson_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lesson_page_index_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/is_lesson_complete_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/mark_lesson_complete.dart';
import 'package:test_practic/domain/usecases/lessons/save_lesson_page_index_usecase.dart';
import 'package:test_practic/presentation/features/lessons/states/lesson_theory_state.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';

part 'lesson_theory_provider.g.dart';

@riverpod
class LessonTheory extends _$LessonTheory {
  late final GetLessonByIdUseCase _getLessonByIdUseCase;
  late final GetLessonPageIndexUseCase _getLessonPageIndexUseCase;
  late final SaveLessonPageIndexUseCase _saveLessonPageIndexUseCase;
  late final IsLessonCompletedUseCase _isLessonCompletedUseCase;
  late final MarkLessonCompletedUseCase _markLessonCompletedUseCase;
  late final int _userId;

  @override
  Future<LessonTheoryState> build(int lessonId) async {
    _getLessonByIdUseCase = GetIt.I<GetLessonByIdUseCase>();
    _getLessonPageIndexUseCase = GetIt.I<GetLessonPageIndexUseCase>();
    _saveLessonPageIndexUseCase = GetIt.I<SaveLessonPageIndexUseCase>();
    _isLessonCompletedUseCase = GetIt.I<IsLessonCompletedUseCase>();
    _markLessonCompletedUseCase = GetIt.I<MarkLessonCompletedUseCase>();

    final authState = ref.watch(authProvider);
    _userId = authState is Authenticated ? authState.user.id : -1;

    final lesson = await _getLessonByIdUseCase.execute(lessonId);
    final parts = lesson.theory.split('---');
    final savedIndex = _getLessonPageIndexUseCase.execute(_userId, lessonId);
    final isFinished = _isLessonCompletedUseCase.execute(_userId, lessonId) || parts.length == 1;

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

    _saveLessonPageIndexUseCase.execute(_userId, lessonId, newIndex);
    if (finished) {
      _markLessonCompletedUseCase.execute(_userId, lessonId);
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
    _saveLessonPageIndexUseCase.execute(_userId, lessonId, newIndex);
    state = AsyncValue.data(s.copyWith(index: newIndex));
  }
}