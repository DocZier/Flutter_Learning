import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/lesson_model.dart';
import '../../data/repositories/lessons_repository.dart';
import '../state/lessons_list_state.dart';

part 'lessons_list_provider.g.dart';


@riverpod
class LessonsList extends _$LessonsList {
  @override
  Future<LessonsListState> build() async {
    final repo = GetIt.I<LessonsRepository>();

    final lessons = await repo.getLessons();

    final lessonModels = lessons.map(LessonModel.fromEntity).toList();

    return LessonsListState(
      lessons: lessonModels,
      filtered: lessonModels.where((l) => l.level.toUpperCase() == "N5").toList(),
      selectedLevel: "N5",
      isLoading: false,
    );
  }

  void filterByLevel(String level) {
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