import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonByIdUseCase {
  final LessonsRepository repository;

  GetLessonByIdUseCase(this.repository);

  Future<LessonModel> execute(int id) async {
    return await repository.getLessonById(id);
  }
}
