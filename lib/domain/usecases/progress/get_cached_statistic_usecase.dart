import 'package:test_practic/core/models/progress/stats_entity.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class GetCachedStatisticsUseCase {
  final ProgressRepository repository;

  GetCachedStatisticsUseCase(this.repository);

  StatisticsEntity? execute(int userId) {
    return repository.getCachedStatistics(userId);
  }
}
