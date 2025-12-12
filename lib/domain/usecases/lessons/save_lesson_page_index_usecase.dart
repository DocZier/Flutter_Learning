import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/lessons/lessons_repository.dart';

class SaveLessonPageIndexUseCase {
  final LessonsRepository repository;

  SaveLessonPageIndexUseCase(this.repository);

  void execute(int userId, int lessonId, int pageIndex) {
    repository.saveLessonPageIndex(userId, lessonId, pageIndex);
  }
}
