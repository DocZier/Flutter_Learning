import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class ComputeStatisticsUseCase {
  final ProgressRepository repository;

  ComputeStatisticsUseCase(this.repository);

  Future<StatisticsModel> execute(int userId) async {
    return await repository.computeStatisticsForUser(userId);
  }
}
