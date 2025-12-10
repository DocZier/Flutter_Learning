class LessonEntity {
  final int id;
  final String title;
  final String description;
  final String theory;
  final String level;

  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.theory,
    required this.level,
  });

  LessonEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? theory,
    String? level,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      theory: theory ?? this.theory,
      level: level ?? this.level,
    );
  }
}
