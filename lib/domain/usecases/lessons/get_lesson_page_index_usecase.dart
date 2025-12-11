import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonPageIndexUseCase {
  final LessonsRepository repository;

  GetLessonPageIndexUseCase(this.repository);

  int execute(int userId, int lessonId) {
    return repository.getLessonPageIndex(userId, lessonId);
  }
}