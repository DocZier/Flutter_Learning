import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/progress/progress_repository.dart';

class GetCachedStatisticsUseCase {
  final ProgressRepository repository;

  GetCachedStatisticsUseCase(this.repository);

  StatisticsModel? execute(int userId) {
    return repository.getCachedStatistics(userId);
  }
}
