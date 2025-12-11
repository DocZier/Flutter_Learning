class LessonTheoryState {
  final List<String> parts;
  final int index;
  final bool finished;

  LessonTheoryState({
    required this.parts,
    required this.index,
    required this.finished,
  });

  LessonTheoryState copyWith({
    List<String>? parts,
    int? index,
    bool? finished,
  }) {
    return LessonTheoryState(
      parts: parts ?? this.parts,
      index: index ?? this.index,
      finished: finished ?? this.finished,
    );
  }
}