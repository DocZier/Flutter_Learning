import '../../data/model/test_model.dart';

class LessonTestState {
  final int lessonId;
  final List<TestModel> questions;
  final int index;

  final int? selectedOption;
  final bool showCorrect;

  final bool correct;
  final String? theory;
  final String? translation;

  final List<int> mistakes;
  final bool finished;

  LessonTestState({
    required this.lessonId,
    required this.questions,
    required this.index,
    required this.selectedOption,
    required this.showCorrect,
    required this.correct,
    required this.theory,
    required this.translation,
    required this.mistakes,
    required this.finished,
  });

  LessonTestState copyWith({
    int? lessonId,
    List<TestModel>? questions,
    int? index,
    int? selectedOption,
    bool? showCorrect,
    bool? correct,
    String? theory,
    String? translation,
    List<int>? mistakes,
    bool? finished,
  }) {
    return LessonTestState(
      lessonId: lessonId ?? this.lessonId,
      questions: questions ?? this.questions,
      index: index ?? this.index,
      selectedOption: selectedOption ?? this.selectedOption,
      showCorrect: showCorrect ?? this.showCorrect,
      correct: correct ?? this.correct,
      theory: theory ?? this.theory,
      translation: translation ?? this.translation,
      mistakes: mistakes ?? this.mistakes,
      finished: finished ?? this.finished,
    );
  }
}