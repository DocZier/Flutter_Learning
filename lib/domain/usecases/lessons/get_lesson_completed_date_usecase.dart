import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonCompletedDateUseCase {
  final LessonsRepository repository;

  GetLessonCompletedDateUseCase(this.repository);

  DateTime? execute(int userId, int lessonId) {
    return repository.getLessonCompletedDate(userId, lessonId);
  }
}