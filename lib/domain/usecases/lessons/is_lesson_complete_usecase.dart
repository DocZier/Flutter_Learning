import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class IsLessonCompletedUseCase {
  final LessonsRepository repository;

  IsLessonCompletedUseCase(this.repository);

  bool execute(int userId, int lessonId) {
    return repository.isLessonCompleted(userId, lessonId);
  }
}