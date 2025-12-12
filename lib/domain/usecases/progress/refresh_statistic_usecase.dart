import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/progress/progress_repository.dart';

class RefreshStatisticsUseCase {
  final ProgressRepository repository;

  RefreshStatisticsUseCase(this.repository);

  Future<StatisticsModel> execute(int userId) async {
    return await repository.refreshStatistics(userId);
  }
}
