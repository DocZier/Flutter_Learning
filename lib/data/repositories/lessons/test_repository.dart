import 'package:test_practic/core/models/lessons/test_entity.dart';

import '../../datasources/local/lessons/test_local_source.dart';
import '../../datasources/remote/lessons/test_remote_source.dart';

abstract class TestsRepository {
  Future<List<TestEntity>> getQuestionsForLesson(int lessonId, {required int userId});
  List<TestEntity> getDueQuestionsForReview(int userId);
  void addToReviewQueue(int userId, int lessonId, TestEntity question, {int interval = 1});
  void updateReviewInterval(int userId, int questionId, bool correct);
  Map<String, dynamic> getStatsForUser(int userId);
  void addStat(int userId, int lessonId, {required bool correct});
  void clearUserProgress(int userId);
}

class TestsRepositoryImpl extends TestsRepository {
  final TestsRemoteDataSource remoteDataSource;
  final TestsLocalDataSource localDataSource;

  TestsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<TestEntity>> getQuestionsForLesson(int lessonId, {required int userId}) async {
    try {
      final questions = await remoteDataSource.getQuestionsForLesson(lessonId);
      final reviewQuestions = localDataSource.getDueQuestionsForUser(userId)
          .where((q) => q.lessonId == lessonId)
          .toList();

      return [...reviewQuestions, ...questions]..shuffle();
    } catch (e) {
      return localDataSource.getDueQuestionsForUser(userId)
          .where((q) => q.lessonId == lessonId)
          .toList();
    }
  }


  @override
  List<TestEntity> getDueQuestionsForReview(int userId) {
    return remoteDataSource.getDueReviewQuestions(userId, -1);
  }

  @override
  void addToReviewQueue(int userId, int lessonId, TestEntity question, {int interval = 1}) {
    remoteDataSource.addToReviewQueue(userId, question.copyWith(
        lessonId: lessonId,
        nextReviewDate: DateTime.now().add(Duration(days: interval))
    ), interval: interval);
  }

  @override
  void updateReviewInterval(int userId, int questionId, bool correct) {
    remoteDataSource.updateReviewInterval(userId, questionId, correct);
  }

  @override
  void addStat(int userId, int lessonId, {required bool correct}) {
    remoteDataSource.addStat(userId, lessonId, correct: correct);
    localDataSource.addStat(userId, lessonId, correct: correct);
  }

  @override
  Map<String, dynamic> getStatsForUser(int userId) {
    return remoteDataSource.getUserStats(userId);
  }

  @override
  void clearUserProgress(int userId) {
    remoteDataSource.clearUserProgress(userId);
    localDataSource.clearUserProgress(userId);
  }
}
