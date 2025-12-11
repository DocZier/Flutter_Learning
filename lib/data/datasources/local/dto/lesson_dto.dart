class LessonLocalDto {
  final int id;
  final String title;
  final String description;
  final String theory;
  final String level;
  final bool completed;
  final DateTime? nextReviewDate;

  LessonLocalDto({
    required this.id,
    required this.title,
    required this.description,
    required this.theory,
    required this.level,
    required this.completed,
    this.nextReviewDate,
  });

  factory LessonLocalDto.fromJson(Map<String, dynamic> json) {
    return LessonLocalDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      theory: json['theory'],
      level: json['level'],
      completed: json['completed'],
      nextReviewDate: json['nextReviewDate'] != null
          ? DateTime.parse(json['nextReviewDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'theory': theory,
      'level': level,
      'completed': completed,
      'nextReviewDate': nextReviewDate?.toIso8601String(),
    };
  }
}