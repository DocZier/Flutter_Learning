import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class MarkLessonCompletedUseCase {
  final LessonsRepository repository;

  MarkLessonCompletedUseCase(this.repository);

  void execute(int userId, int lessonId) {
    repository.markLessonCompleted(userId, lessonId);
  }
}