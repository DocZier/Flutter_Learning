import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/core/models/shared/learining_progress_enity.dart';
import 'package:test_practic/data/datasources/local/progress_local_source.dart';
import 'package:test_practic/data/datasources/remote/progress_remote_source.dart';
import '../fllashcards/flashcard_repository.dart';
import '../lessons/lessons_repository.dart';
import '../lessons/test_repository.dart';

abstract class ProgressRepository {
  Future<StatisticsModel> computeStatisticsForUser(int userId);
  StatisticsModel? getCachedStatistics(int userId);
  Future<StatisticsModel> refreshStatistics(int userId);
  Future<void> saveStatistics(StatisticsModel stats);
  Future<List<LearningProgressModel>> getLearningProgressHistory(int userId, {int days = 30});
}