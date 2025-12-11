import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonsUseCase {
  final LessonsRepository repository;

  GetLessonsUseCase(this.repository);

  Future<List<LessonModel>> execute({String? level, int? userId}) async {
    return await repository.getLessons(level: level, userId: userId);
  }
}