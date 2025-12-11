
import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/datasources/local/test_local_source.dart';
import 'package:test_practic/data/datasources/remote/test_remote_source.dart';

abstract class TestsRepository {
  Future<List<TestModel>> getQuestionsForLesson(int lessonId, {required int userId});
  List<TestModel> getDueQuestionsForReview(int userId);
  void addToReviewQueue(int userId, int lessonId, TestModel question, {int interval = 1});
  void updateReviewInterval(int userId, int questionId, bool correct);
  Map<String, dynamic> getStatsForUser(int userId);
  void addStat(int userId, int lessonId, {required bool correct});
  void clearUserProgress(int userId);
}

class TestsRepositoryImpl implements TestsRepository {
  final TestsRemoteDataSource _remoteDataSource;
  final TestsLocalDataSource _localDataSource;

  TestsRepositoryImpl({
    required TestsRemoteDataSource remoteDataSource,
    required TestsLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<List<TestModel>> getQuestionsForLesson(int lessonId, {required int userId}) async {
    try {
      final questions = await _remoteDataSource.getQuestionsForLesson(lessonId);
      final reviewQuestions = _localDataSource.getDueQuestionsForUser(userId)
          .where((q) => q.lessonId == lessonId)
          .toList();
      return [...reviewQuestions, ...questions]..shuffle();
    } catch (e) {
      return _localDataSource.getDueQuestionsForUser(userId)
          .where((q) => q.lessonId == lessonId)
          .toList();
    }
  }

  @override
  List<TestModel> getDueQuestionsForReview(int userId) {
    return _remoteDataSource.getDueReviewQuestions(userId, -1);
  }

  @override
  void addToReviewQueue(int userId, int lessonId, TestModel question, {int interval = 1}) {
    _remoteDataSource.addToReviewQueue(userId, question.copyWith(
      lessonId: lessonId,
    ), interval: interval);
    _localDataSource.cacheReviewQuestions(userId, [
      ..._localDataSource.getDueQuestionsForUser(userId),
      question.copyWith(
        lessonId: lessonId,
        nextReviewDate: DateTime.now().add(Duration(days: interval)),
      ),
    ]);
  }

  @override
  void updateReviewInterval(int userId, int questionId, bool correct) {
    _remoteDataSource.updateReviewInterval(userId, questionId, correct);
  }

  @override
  void addStat(int userId, int lessonId, {required bool correct}) {
    _remoteDataSource.addStat(userId, lessonId, correct: correct);
    _localDataSource.addStat(userId, lessonId, correct: correct);
  }

  @override
  Map<String, dynamic> getStatsForUser(int userId) {
    return _remoteDataSource.getUserStats(userId);
  }

  @override
  void clearUserProgress(int userId) {
    _remoteDataSource.clearUserProgress(userId);
    _localDataSource.clearUserProgress(userId);
  }
}