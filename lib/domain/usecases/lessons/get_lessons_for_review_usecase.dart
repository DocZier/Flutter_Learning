import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/repositories/lessons/lessons_repository.dart';

class GetLessonsForReviewUseCase {
  final LessonsRepository repository;

  GetLessonsForReviewUseCase(this.repository);

  List<LessonModel> execute(int userId) {
    return repository.getLessonsForReview(userId);
  }
}