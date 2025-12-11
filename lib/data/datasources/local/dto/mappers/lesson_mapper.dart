import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/datasources/local/dto/lesson_dto.dart';

extension LessonLocalMapper on LessonLocalDto {
  LessonModel toModel() {
    return LessonModel(
      id: id,
      title: title,
      description: description,
      theory: theory,
      level: level,
      completed: completed,
      nextReviewDate: nextReviewDate,
    );
  }
}

extension LessonModelLocalMapper on LessonModel {
  LessonLocalDto toLocalDto() {
    return LessonLocalDto(
      id: id,
      title: title,
      description: description,
      theory: theory,
      level: level,
      completed: completed,
      nextReviewDate: nextReviewDate,
    );
  }
}