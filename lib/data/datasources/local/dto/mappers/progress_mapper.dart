
import 'package:test_practic/core/models/progress/stats_model.dart';
import 'package:test_practic/data/datasources/local/dto/progress_dto.dart';

extension StatisticsLocalMapper on StatisticsLocalDto {
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

extension StatisticsModelLocalMapper on StatisticsModel {
  StatisticsLocalDto toLocalDto() {
    return StatisticsLocalDto(
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