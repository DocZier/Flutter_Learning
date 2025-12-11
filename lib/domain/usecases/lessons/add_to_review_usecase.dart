import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class AddToReviewUseCase {
  final TestsRepository repository;

  AddToReviewUseCase(this.repository);

  void execute(int userId, int lessonId, TestModel question, {int interval = 1}) {
    repository.addToReviewQueue(userId, lessonId, question, interval: interval);
  }
}
