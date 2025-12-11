import 'package:test_practic/core/models/lessons/lesson_entity.dart';
import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonByIdUseCase {
  final LessonsRepository repository;

  GetLessonByIdUseCase(this.repository);

  Future<LessonEntity> execute(int id) async {
    return await repository.getLessonById(id);
  }
}
