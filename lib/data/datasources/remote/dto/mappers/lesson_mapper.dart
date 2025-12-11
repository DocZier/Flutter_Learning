import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/datasources/remote/dto/lesson_dto.dart';

extension LessonRemoteMapper on LessonRemoteDto {
  LessonModel toModel({
    bool completed = false,
    DateTime? nextReviewDate,
  }) {
    final theoryCombined = theoryPages
        .map((page) => '${page['title']}\n${page['description']}')
        .join('\n---\n');

    return LessonModel(
      id: id,
      title: title,
      description: description,
      theory: theoryCombined,
      level: level,
      completed: completed,
      nextReviewDate: nextReviewDate,
    );
  }
}

extension LessonModelRemoteMapper on LessonModel {
  LessonRemoteDto toRemoteDto() {
    final theoryPages = theory.split('\n---\n').map((part) {
      final lines = part.split('\n');
      return {
        'title': lines.first,
        'description': lines.length > 1 ? lines.skip(1).join('\n') : '',
      };
    }).toList();

    return LessonRemoteDto(
      id: id,
      title: title,
      description: description,
      theoryPages: theoryPages,
      level: level,
    );
  }
}