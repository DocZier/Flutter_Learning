import '../../../flashcards/data/repositories/flashcard_repository.dart';
import '../../../lessons/data/repositories/lessons_repository.dart';
import '../../../lessons/data/repositories/test_repository.dart';
import '../../domain/entities/learining_progress_entry.dart';
import '../../domain/entities/stats_entity.dart';
import '../sources/local/stats_local_source.dart';
import '../sources/remote/stats_remote_source.dart';
abstract class StatsRepository {
  Future<StatisticsEntity> computeStatisticsForUser(int userId);
  StatisticsEntity? getCachedStatistics(int userId);
  Future<StatisticsEntity> refreshStatistics(int userId);
  Future<void> saveStatistics(StatisticsEntity stats);
  Future<List<LearningProgressEntry>> getLearningProgressHistory(int userId, {int days = 30});
}

class StatsRepositoryImpl implements StatsRepository {
  final FlashcardRepository flashcardRepository;
  final LessonsRepository lessonsRepository;
  final TestsRepository testsRepository;
  final StatsLocalSource _local;
  final StatsRemoteSource _remote;

  StatsRepositoryImpl({
    required this.flashcardRepository,
    required this.lessonsRepository,
    required this.testsRepository,
    required StatsLocalSource localSource,
    required StatsRemoteSource remoteSource,
  })  : _local = localSource,
        _remote = remoteSource;

  @override
  StatisticsEntity? getCachedStatistics(int userId) => _local.getStatistics(userId);

  @override
  Future<StatisticsEntity> computeStatisticsForUser(int userId) async {
    final decks = flashcardRepository.getUsersDecks(userId);
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
      final cards = flashcardRepository.getFlashcardsByDeckId(deck.id);
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

    final lessons = await lessonsRepository.getLessons(userId: userId);
    final totalLessonsAvailable = lessons.length;
    int completedLessons = 0;
    DateTime? firstLessonDate;
    DateTime? lastLessonDate;

    for (final lesson in lessons) {
      if (lessonsRepository.isLessonCompleted(userId, lesson.id)) {
        completedLessons++;
        final completionDate = lessonsRepository.getLessonCompletedDate(userId, lesson.id);
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

    final userStats = testsRepository.getStatsForUser(userId);
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

    final stats = StatisticsEntity(
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
  Future<List<LearningProgressEntry>> getLearningProgressHistory(
      int userId, {int days = 30}) async {
    final today = DateTime.now();
    final history = <LearningProgressEntry>[];

    for (int i = days - 1; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final lessonsCompleted = (i * 2) % 5;
      final cardsReviewed = (i * 3) % 8;

      history.add(LearningProgressEntry(
        date: date,
        lessonsCompleted: lessonsCompleted,
        cardsReviewed: cardsReviewed,
      ));
    }

    return history;
  }

  @override
  Future<StatisticsEntity> refreshStatistics(int userId) async {
    final remote = await _remote.fetchStatistics(userId);
    if (remote != null) {
      _local.saveStatistics(remote);
      return remote;
    }
    return await computeStatisticsForUser(userId);
  }

  @override
  Future<void> saveStatistics(StatisticsEntity stats) async {
    _local.saveStatistics(stats);
    await _remote.saveStatistics(stats);
  }
}