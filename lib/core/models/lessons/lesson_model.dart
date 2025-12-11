import 'lesson_entity.dart';

class LessonModel extends LessonEntity {

  const LessonModel({
    required super.id,
    required super.title,
    required super.description,
    required super.theory,
    required super.level,
    required super.completed
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      theory: json['theory'],
        level: json['level'],
        completed: json['completed']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'theory': theory,
    'level': level,
    'completed': completed
  };

  factory LessonModel.fromEntity(LessonEntity entity) {
    return LessonModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      theory: entity.theory,
      level: entity.level,
        completed: entity.completed
    );
  }

  LessonEntity toEntity() => LessonEntity(
    id: id,
    title: title,
    description: description,
    theory: theory,
    level: level,
    completed: completed
  );
}
