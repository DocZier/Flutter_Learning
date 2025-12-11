class LessonRemoteDto {
  final int id;
  final String title;
  final String description;
  final List<Map<String, dynamic>> theoryPages;
  final String level;

  LessonRemoteDto({
    required this.id,
    required this.title,
    required this.description,
    required this.theoryPages,
    required this.level,
  });

  factory LessonRemoteDto.fromJson(Map<String, dynamic> json) {
    return LessonRemoteDto(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      theoryPages: List<Map<String, dynamic>>.from(json['theory_pages']),
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'theory_pages': theoryPages,
      'level': level,
    };
  }
}