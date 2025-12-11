import '../../../../core/models/progress/stats_entity.dart';
import '../../../../core/models/progress/stats_model.dart';

class ProgressLocalSource {
  static final Map<int, Map<String, dynamic>> _cache = {};

  void saveStatistics(StatisticsEntity stats) {
    _cache[stats.userId] = (StatisticsModel.fromEntity(stats)).toJson();
  }

  StatisticsEntity? getStatistics(int userId) {
    final m = _cache[userId];
    if (m == null) return null;
    return StatisticsModel.fromJson(m).toEntity();
  }

  void clearCache(int userId) => _cache.remove(userId);
}