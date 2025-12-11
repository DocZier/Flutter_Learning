import 'package:test_practic/data/datasources/local/dto/mappers/progress_mapper.dart';
import 'package:test_practic/data/datasources/local/dto/progress_dto.dart';
import '../../../core/models/progress/stats_model.dart';


class ProgressLocalSource {
  static final Map<int, StatisticsLocalDto> _cache = {};

  void saveStatistics(StatisticsModel stats) {
    _cache[stats.userId] = stats.toLocalDto();
  }

  StatisticsModel? getStatistics(int userId) {
    final dto = _cache[userId];
    return dto?.toModel();
  }

  void clearCache(int userId) => _cache.remove(userId);
}