class StatisticsRemoteDto {
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

  StatisticsRemoteDto({
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

  factory StatisticsRemoteDto.fromJson(Map<String, dynamic> json) {
    return StatisticsRemoteDto(
      userId: json['userId'],
      totalDecks: json['totalDecks'],
      totalFlashcards: json['totalFlashcards'],
      cardsDueToday: json['cardsDueToday'],
      cardsReviewedToday: json['cardsReviewedToday'],
      averageEaseFactor: (json['averageEaseFactor'] as num).toDouble(),
      totalLessonsAvailable: json['totalLessonsAvailable'],
      completedLessons: json['completedLessons'],
      testsTotalAttempts: json['testsTotalAttempts'],
      testsCorrectAnswers: json['testsCorrectAnswers'],
      retentionRate: json['retentionRate'],
      daysSinceFirstActivity: json['daysSinceFirstActivity'],
      daysSinceLastActivity: json['daysSinceLastActivity'],
      learningStreak: json['learningStreak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalDecks': totalDecks,
      'totalFlashcards': totalFlashcards,
      'cardsDueToday': cardsDueToday,
      'cardsReviewedToday': cardsReviewedToday,
      'averageEaseFactor': averageEaseFactor,
      'totalLessonsAvailable': totalLessonsAvailable,
      'completedLessons': completedLessons,
      'testsTotalAttempts': testsTotalAttempts,
      'testsCorrectAnswers': testsCorrectAnswers,
      'retentionRate': retentionRate,
      'daysSinceFirstActivity': daysSinceFirstActivity,
      'daysSinceLastActivity': daysSinceLastActivity,
      'learningStreak': learningStreak,
    };
  }
}