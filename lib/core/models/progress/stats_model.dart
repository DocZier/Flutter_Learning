import 'stats_entity.dart';

class StatisticsModel extends StatisticsEntity {
  const StatisticsModel({
    required super.userId,
    required super.totalDecks,
    required super.totalFlashcards,
    required super.cardsDueToday,
    required super.cardsReviewedToday,
    required super.averageEaseFactor,
    required super.totalLessonsAvailable,
    required super.completedLessons,
    required super.testsTotalAttempts,
    required super.testsCorrectAnswers,
    required super.retentionRate,
    required super.daysSinceFirstActivity,
    required super.daysSinceLastActivity,
    required super.learningStreak,
  });

  factory StatisticsModel.fromEntity(StatisticsEntity e) => StatisticsModel(
    userId: e.userId,
    totalDecks: e.totalDecks,
    totalFlashcards: e.totalFlashcards,
    cardsDueToday: e.cardsDueToday,
    cardsReviewedToday: e.cardsReviewedToday,
    averageEaseFactor: e.averageEaseFactor,
    totalLessonsAvailable: e.totalLessonsAvailable,
    completedLessons: e.completedLessons,
    testsTotalAttempts: e.testsTotalAttempts,
    testsCorrectAnswers: e.testsCorrectAnswers,
    retentionRate: e.retentionRate,
    daysSinceFirstActivity: e.daysSinceFirstActivity,
    daysSinceLastActivity: e.daysSinceLastActivity,
    learningStreak: e.learningStreak,
  );

  StatisticsEntity toEntity() => StatisticsEntity(
    userId: userId,
    totalDecks: totalDecks,
    totalFlashcards: totalFlashcards,
    cardsDueToday: cardsDueToday,
    cardsReviewedToday: cardsReviewedToday,
    averageEaseFactor: averageEaseFactor,
    totalLessonsAvailable: totalLessonsAvailable,
    completedLessons: completedLessons,
    testsTotalAttempts: testsTotalAttempts,
    testsCorrectAnswers: testsCorrectAnswers,
    retentionRate: retentionRate,
    daysSinceFirstActivity: daysSinceFirstActivity,
    daysSinceLastActivity: daysSinceLastActivity,
    learningStreak: learningStreak,
  );

  Map<String, dynamic> toJson() => {
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

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
    userId: json['userId'] as int,
    totalDecks: json['totalDecks'] as int,
    totalFlashcards: json['totalFlashcards'] as int,
    cardsDueToday: json['cardsDueToday'] as int,
    cardsReviewedToday: json['cardsReviewedToday'] as int,
    averageEaseFactor: (json['averageEaseFactor'] as num).toDouble(),
    totalLessonsAvailable: json['totalLessonsAvailable'] as int,
    completedLessons: json['completedLessons'] as int,
    testsTotalAttempts: json['testsTotalAttempts'] as int,
    testsCorrectAnswers: json['testsCorrectAnswers'] as int,
    retentionRate: json['retentionRate'] as int,
    daysSinceFirstActivity: json['daysSinceFirstActivity'] as int,
    daysSinceLastActivity: json['daysSinceLastActivity'] as int,
    learningStreak: json['learningStreak'] as int,
  );
}