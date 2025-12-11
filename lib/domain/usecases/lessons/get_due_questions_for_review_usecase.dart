import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class GetDueQuestionsForReviewUseCase {
  final TestsRepository repository;

  GetDueQuestionsForReviewUseCase(this.repository);

  List<TestModel> execute(int userId) {
    return repository.getDueQuestionsForReview(userId);
  }
}