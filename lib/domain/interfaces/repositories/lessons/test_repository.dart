
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