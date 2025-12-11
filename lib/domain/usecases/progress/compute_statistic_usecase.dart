import 'package:test_practic/core/models/progress/stats_entity.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class ComputeStatisticsUseCase {
  final ProgressRepository repository;

  ComputeStatisticsUseCase(this.repository);

  Future<StatisticsEntity> execute(int userId) async {
    return await repository.computeStatisticsForUser(userId);
  }
}
