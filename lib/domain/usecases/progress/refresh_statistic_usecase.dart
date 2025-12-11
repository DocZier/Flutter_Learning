import 'package:test_practic/core/models/progress/stats_entity.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class RefreshStatisticsUseCase {
  final ProgressRepository repository;

  RefreshStatisticsUseCase(this.repository);

  Future<StatisticsEntity> execute(int userId) async {
    return await repository.refreshStatistics(userId);
  }
}
