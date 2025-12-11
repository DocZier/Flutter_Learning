import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class UpdateReviewIntervalUseCase {
  final TestsRepository repository;

  UpdateReviewIntervalUseCase(this.repository);

  void execute(int userId, int questionId, bool correct) {
    repository.updateReviewInterval(userId, questionId, correct);
  }
}