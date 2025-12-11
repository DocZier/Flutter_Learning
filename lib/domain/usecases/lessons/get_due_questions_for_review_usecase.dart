import 'package:test_practic/core/models/lessons/test_entity.dart';
import 'package:test_practic/data/repositories/lessons/test_repository.dart';

class GetDueQuestionsForReviewUseCase {
  final TestsRepository repository;

  GetDueQuestionsForReviewUseCase(this.repository);

  List<TestEntity> execute(int userId) {
    return repository.getDueQuestionsForReview(userId);
  }
}