
import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/data/datasources/remote/dto/progress_remote.dart';

extension StatisticsRemoteMapper on StatisticsRemoteDto {
  StatisticsModel toModel() {
    return StatisticsModel(
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
  }
}

extension StatisticsModelRemoteMapper on StatisticsModel {
  StatisticsRemoteDto toRemoteDto() {
    return StatisticsRemoteDto(
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
  }
}