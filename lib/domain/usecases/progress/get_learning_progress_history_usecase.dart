import 'package:test_practic/core/models/shared/learining_progress_enity.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class GetLearningProgressHistoryUseCase {
  final ProgressRepository repository;

  GetLearningProgressHistoryUseCase(this.repository);

  Future<List<LearningProgressModel>> execute(int userId, {int days = 30}) async {
    return await repository.getLearningProgressHistory(userId, days: days);
  }
}