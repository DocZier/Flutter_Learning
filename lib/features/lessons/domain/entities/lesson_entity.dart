class LessonEntity {
  final int id;
  final String title;
  final String description;
  final String theory;
  final String level;
  final bool completed;
  final DateTime? nextReviewDate;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.theory,
    required this.level,
    required this.completed,
    this.nextReviewDate,
  });

  LessonEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? theory,
    String? level,
    bool? completed,
    DateTime? nextReviewDate,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      theory: theory ?? this.theory,
      level: level ?? this.level,
      completed: completed ?? this.completed,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
    );
  }
}