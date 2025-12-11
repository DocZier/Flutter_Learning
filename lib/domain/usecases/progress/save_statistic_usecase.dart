import 'package:test_practic/core/models/progress/stats_entity.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';

class SaveStatisticsUseCase {
  final ProgressRepository repository;

  SaveStatisticsUseCase(this.repository);

  Future<void> execute(StatisticsEntity stats) async {
    await repository.saveStatistics(stats);
  }
}