import '../../../domain/entities/stats_entity.dart';
import '../../model/stats_model.dart';

class StatsRemoteSource {
  static final Map<int, Map<String, dynamic>> _remote = {};

  Future<void> saveStatistics(StatisticsEntity stats) async {
    _remote[stats.userId] = StatisticsModel.fromEntity(stats).toJson();
  }

  Future<StatisticsEntity?> fetchStatistics(int userId) async {
    await Future.delayed(const Duration(milliseconds: 120));
    final m = _remote[userId];
    if (m == null) return null;
    return StatisticsModel.fromJson(m).toEntity();
  }
}