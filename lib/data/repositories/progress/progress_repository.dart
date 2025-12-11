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

class ProgressRepositoryImpl implements ProgressRepository {
  final FlashcardRepository _flashcardRepository;
  final LessonsRepository _lessonsRepository;
  final TestsRepository _testsRepository;
  final ProgressLocalSource _local;
  final ProgressRemoteSource _remote;

  ProgressRepositoryImpl({
    required FlashcardRepository flashcardRepository,
    required LessonsRepository lessonsRepository,
    required TestsRepository testsRepository,
    required ProgressLocalSource localSource,
    required ProgressRemoteSource remoteSource,
  })  : _flashcardRepository = flashcardRepository,
        _lessonsRepository = lessonsRepository,
        _testsRepository = testsRepository,
        _local = localSource,
        _remote = remoteSource;

  @override
  StatisticsModel? getCachedStatistics(int userId) => _local.getStatistics(userId);

  @override
  Future<StatisticsModel> computeStatisticsForUser(int userId) async {
    final decks = _flashcardRepository.getUsersDecks(userId);
    final totalDecks = decks.length;
    int totalFlashcards = 0;
    int cardsDueToday = 0;
    int cardsReviewedToday = 0;
    double easeSum = 0.0;
    int easeCount = 0;
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final endOfToday = startOfToday.add(const Duration(days: 1));

    for (final deck in decks) {
      final cards = _flashcardRepository.getFlashcardsByDeckId(deck.id);
      totalFlashcards += cards.length;
      for (final c in cards) {
        if (c.nextReview.isBefore(now) || c.nextReview.isAtSameMomentAs(now)) {
          cardsDueToday++;
        }
        if (c.lastReviewedAt.isAfter(startOfToday) && c.lastReviewedAt.isBefore(endOfToday)) {
          cardsReviewedToday++;
        }
        easeSum += c.easeFactor;
        easeCount++;
      }
    }

    final averageEaseFactor = easeCount == 0 ? 0.0 : (easeSum / easeCount);

    final lessons = await _lessonsRepository.getLessons(userId: userId);
    final totalLessonsAvailable = lessons.length;
    int completedLessons = 0;
    DateTime? firstLessonDate;
    DateTime? lastLessonDate;

    for (final lesson in lessons) {
      if (_lessonsRepository.isLessonCompleted(userId, lesson.id)) {
        completedLessons++;
        final completionDate = _lessonsRepository.getLessonCompletedDate(userId, lesson.id);
        if (completionDate != null) {
          if (firstLessonDate == null || completionDate.isBefore(firstLessonDate)) {
            firstLessonDate = completionDate;
          }
          if (lastLessonDate == null || completionDate.isAfter(lastLessonDate)) {
            lastLessonDate = completionDate;
          }
        }
      }
    }

    int testsTotalAttempts = 0;
    int testsCorrectAnswers = 0;
    final userStats = _testsRepository.getStatsForUser(userId);
    final byLessonStats = userStats['byLesson'] as Map<int, Map<String, int>>?;

    if (byLessonStats != null) {
      byLessonStats.forEach((lessonId, stats) {
        testsTotalAttempts += stats['total'] ?? 0;
        testsCorrectAnswers += stats['correct'] ?? 0;
      });
    }

    final retentionRate = testsTotalAttempts > 0
        ? (testsCorrectAnswers / testsTotalAttempts * 100).round()
        : 0;

    final today = DateTime.now();
    final daysSinceFirstActivity = firstLessonDate != null
        ? today.difference(firstLessonDate).inDays
        : 0;
    final daysSinceLastActivity = lastLessonDate != null
        ? today.difference(lastLessonDate).inDays
        : 0;
    final learningStreak = _calculateLearningStreak(userId, lastLessonDate);

    final stats = StatisticsModel(
      userId: userId,
      totalDecks: totalDecks,
      totalFlashcards: totalFlashcards,
      cardsDueToday: cardsDueToday,
      cardsReviewedToday: cardsReviewedToday,
      averageEaseFactor: double.parse(averageEaseFactor.toStringAsFixed(2)),
      totalLessonsAvailable: totalLessonsAvailable,
      completedLessons: completedLessons,
      testsTotalAttempts: testsTotalAttempts,
      testsCorrectAnswers: testsCorrectAnswers,
      retentionRate: retentionRate,
      daysSinceFirstActivity: daysSinceFirstActivity,
      daysSinceLastActivity: daysSinceLastActivity,
      learningStreak: learningStreak,
    );

    _local.saveStatistics(stats);
    return stats;
  }

  int _calculateLearningStreak(int userId, DateTime? lastActivityDate) {
    if (lastActivityDate == null) return 0;
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    if (lastActivityDate.isAfter(yesterday) || lastActivityDate.isAtSameMomentAs(yesterday)) {
      final cachedStats = getCachedStatistics(userId);
      return (cachedStats?.learningStreak ?? 0) + 1;
    }
    return 1;
  }

  @override
  Future<List<LearningProgressModel>> getLearningProgressHistory(
      int userId, {int days = 30}) async {
    final today = DateTime.now();
    final history = <LearningProgressModel>[];
    for (int i = days - 1; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final lessonsCompleted = (i * 2) % 5;
      final cardsReviewed = (i * 3) % 8;
      history.add(LearningProgressModel(
        date: date,
        lessonsCompleted: lessonsCompleted,
        cardsReviewed: cardsReviewed,
      ));
    }
    return history;
  }

  @override
  Future<StatisticsModel> refreshStatistics(int userId) async {
    final remote = await _remote.fetchStatistics(userId);
    if (remote != null) {
      _local.saveStatistics(remote);
      return remote;
    }
    return await computeStatisticsForUser(userId);
  }

  @override
  Future<void> saveStatistics(StatisticsModel stats) async {
    _local.saveStatistics(stats);
    await _remote.saveStatistics(stats);
  }
}