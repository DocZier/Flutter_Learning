import 'package:test_practic/data/datasources/remote/dto/mappers/progress_mapper.dart';
import 'package:test_practic/data/datasources/remote/dto/progress_remote.dart';

import '../../../core/models/progress/stats_model.dart';

class ProgressRemoteSource {
  static final Map<int, StatisticsRemoteDto> _remote = {};

  Future<void> saveStatistics(StatisticsModel stats) async {
    _remote[stats.userId] = stats.toRemoteDto();
  }

  Future<StatisticsModel?> fetchStatistics(int userId) async {
    await Future.delayed(const Duration(milliseconds: 120));
    final dto = _remote[userId];
    return dto?.toModel();
  }
}