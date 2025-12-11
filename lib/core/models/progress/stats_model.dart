class StatisticsModel {
  final int userId;
  final int totalDecks;
  final int totalFlashcards;
  final int cardsDueToday;
  final int cardsReviewedToday;
  final double averageEaseFactor;
  final int totalLessonsAvailable;
  final int completedLessons;
  final int testsTotalAttempts;
  final int testsCorrectAnswers;
  final int retentionRate;
  final int daysSinceFirstActivity;
  final int daysSinceLastActivity;
  final int learningStreak;

  const StatisticsModel({
    required this.userId,
    required this.totalDecks,
    required this.totalFlashcards,
    required this.cardsDueToday,
    required this.cardsReviewedToday,
    required this.averageEaseFactor,
    required this.totalLessonsAvailable,
    required this.completedLessons,
    required this.testsTotalAttempts,
    required this.testsCorrectAnswers,
    required this.retentionRate,
    required this.daysSinceFirstActivity,
    required this.daysSinceLastActivity,
    required this.learningStreak,
  });

  StatisticsModel copyWith({
    int? userId,
    int? totalDecks,
    int? totalFlashcards,
    int? cardsDueToday,
    int? cardsReviewedToday,
    double? averageEaseFactor,
    int? totalLessonsAvailable,
    int? completedLessons,
    int? testsTotalAttempts,
    int? testsCorrectAnswers,
    int? retentionRate,
    int? daysSinceFirstActivity,
    int? daysSinceLastActivity,
    int? learningStreak,
  }) {
    return StatisticsModel(
      userId: userId ?? this.userId,
      totalDecks: totalDecks ?? this.totalDecks,
      totalFlashcards: totalFlashcards ?? this.totalFlashcards,
      cardsDueToday: cardsDueToday ?? this.cardsDueToday,
      cardsReviewedToday: cardsReviewedToday ?? this.cardsReviewedToday,
      averageEaseFactor: averageEaseFactor ?? this.averageEaseFactor,
      totalLessonsAvailable: totalLessonsAvailable ?? this.totalLessonsAvailable,
      completedLessons: completedLessons ?? this.completedLessons,
      testsTotalAttempts: testsTotalAttempts ?? this.testsTotalAttempts,
      testsCorrectAnswers: testsCorrectAnswers ?? this.testsCorrectAnswers,
      retentionRate: retentionRate ?? this.retentionRate,
      daysSinceFirstActivity: daysSinceFirstActivity ?? this.daysSinceFirstActivity,
      daysSinceLastActivity: daysSinceLastActivity ?? this.daysSinceLastActivity,
      learningStreak: learningStreak ?? this.learningStreak,
    );
  }
}