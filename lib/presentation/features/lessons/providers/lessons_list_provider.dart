import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:test_practic/domain/usecases/lessons/get_lessons_usecase.dart';
import 'package:test_practic/presentation/shared/providers/auth_provider.dart';
import 'package:test_practic/presentation/shared/states/auth_state.dart';
import '../../../../core/models/lessons/lesson_model.dart';
import '../states/lessons_list_state.dart';

part 'lessons_list_provider.g.dart';


@riverpod
class LessonsList extends _$LessonsList {
  late final GetLessonsUseCase _getLessonsUseCase;

  @override
  Future<LessonsListState> build() async {
    _getLessonsUseCase = GetIt.I<GetLessonsUseCase>();

    final authStateAsync = ref.watch(authProvider);
    if (authStateAsync is! AsyncData<AuthState> ||
        authStateAsync.value is! Authenticated) {
      throw Exception('Пользователь не авторизован');
    }

    final authState = authStateAsync.value as Authenticated;
    final userId = authState.user.id;

    final lessons = await _getLessonsUseCase.execute(userId: userId);
    final lessonModels = lessons.map((lesson) => lesson).toList();

    return LessonsListState(
      lessons: lessonModels,
      filtered: lessonModels.where((l) => l.level.toUpperCase() == "N5").toList(),
      selectedLevel: "N5",
      isLoading: false,
    );
  }

  Future<void> filterByLevel(String level) async {
    final current = state.value!;
    if (level == "ALL") {
      state = AsyncValue.data(
        current.copyWith(filtered: current.lessons, selectedLevel: level),
      );
      return;
    }
    state = AsyncValue.data(
      current.copyWith(
        filtered: current.lessons.where((l) => l.level.toUpperCase() == level.toUpperCase()).toList(),
        selectedLevel: level,
      ),
    );
  }
}