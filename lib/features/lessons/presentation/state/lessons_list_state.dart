import '../../data/model/lesson_model.dart';

enum JLPTLevel {
  N5,
  N4,
  N3,
  N2,
  N1
}

class LessonsListState {
  final List<LessonModel> lessons;
  final List<LessonModel> filtered;
  final String selectedLevel;
  final bool isLoading;

  LessonsListState({
    required this.lessons,
    required this.filtered,
    required this.selectedLevel,
    required this.isLoading,
  });

  LessonsListState copyWith({
    List<LessonModel>? lessons,
    List<LessonModel>? filtered,
    String? selectedLevel,
    bool? isLoading,
  }) {
    return LessonsListState(
      lessons: lessons ?? this.lessons,
      filtered: filtered ?? this.filtered,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
