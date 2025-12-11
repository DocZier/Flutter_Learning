import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class ClearUserLessonProgressUseCase {
  final LessonsRepository repository;

  ClearUserLessonProgressUseCase(this.repository);

  void execute(int userId) {
    repository.clearUserProgress(userId);
  }
}