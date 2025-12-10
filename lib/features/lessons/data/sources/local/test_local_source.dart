
import 'package:test_practic/features/lessons/domain/entities/test_entity.dart';

class TestsLocalDataSource {
  static final Map<int, List<TestEntity>> _cachedReviewQuestions = {};
  static final Map<int, Map<int, Map<String, int>>> _stats = {};

  List<TestEntity> getDueQuestionsForUser(int userId) {
    return _cachedReviewQuestions[userId] ?? [];
  }

  void cacheReviewQuestions(int userId, List<TestEntity> questions) {
    _cachedReviewQuestions[userId] = questions;
  }

  void clearUserProgress(int userId) {
    _cachedReviewQuestions.remove(userId);
  }

  void addStat(int userId, int lessonId, {required bool correct}) {
    _stats.putIfAbsent(userId, () => <int, Map<String, int>>{});
    final userStats = _stats[userId]!;

    if (!userStats.containsKey(lessonId)) {
      userStats[lessonId] = <String, int>{'total': 0, 'correct': 0};
    }

    final lessonStats = userStats[lessonId]!;
    lessonStats['total'] = (lessonStats['total'] ?? 0) + 1;
    if (correct) {
      lessonStats['correct'] = (lessonStats['correct'] ?? 0) + 1;
    }
  }

  Map<String, dynamic> getUserStats(int userId) {
    if (!_stats.containsKey(userId)) {
      return {
        'byLesson': <int, Map<String, int>>{},
        'total': {'total': 0, 'correct': 0},
        'accuracy': 0
      };
    }

    final userStats = _stats[userId]!;
    final totalStats = {'total': 0, 'correct': 0};

    userStats.forEach((lessonId, lessonStats) {
      totalStats['total'] = (totalStats['total'] as int) + (lessonStats['total'] as int);
      totalStats['correct'] = (totalStats['correct'] as int) + (lessonStats['correct'] as int);
    });

    final accuracy = totalStats['total'] != 0
        ? ((totalStats['correct'] as int) / (totalStats['total'] as int) * 100).round()
        : 0;

    return {
      'byLesson': Map<int, Map<String, int>>.from(userStats),
      'total': Map<String, int>.from(totalStats),
      'accuracy': accuracy,
    };
  }
}
