import 'package:test_practic/features/lessons/domain/entities/test_entity.dart';

import '../sources/local/test_local_source.dart';
import '../sources/remote/test_remote_source.dart';

abstract class TestsRepository {
  Future<List<TestEntity>> getQuestionsForLesson(int lessonId);
  List<TestEntity> getRepeatQueue(int lessonId);
  void addToRepeat(int lessonId, TestEntity q);
  void clearRepeatQueue(int lessonId);
  void addStat(int lessonId, {required bool correct});
  Map<String, int> getStats(int lessonId);
}

class TestsRepositoryImpl extends TestsRepository {
  final TestsRemoteDataSource remoteDataSource;
  final TestsLocalDataSource localDataSource;

  TestsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<TestEntity>> getQuestionsForLesson(int lessonId) async {
    try {
      final questions = await remoteDataSource.getQuestionsForLesson(lessonId);
      return questions;
    } catch (e) {
      return localDataSource.getRepeatQueue(lessonId);
    }
  }

  Future<TestEntity> getQuestionById(int lessonId, int questionId) async {
    try {
      final question = await remoteDataSource.getQuestionById(lessonId, questionId);
      return question;
    } catch (e) {
      throw Exception('Question not found');
    }
  }

  @override
  List<TestEntity> getRepeatQueue(int lessonId) => localDataSource.getRepeatQueue(lessonId);

  @override
  void addToRepeat(int lessonId, TestEntity question) => localDataSource.addToRepeat(lessonId, question);

  @override
  void clearRepeatQueue(int lessonId) => localDataSource.clearRepeatQueue(lessonId);

  @override
  void addStat(int lessonId, {required bool correct}) => localDataSource.addStat(lessonId, correct: correct);

  @override
  Map<String, int> getStats(int lessonId) => localDataSource.getStats(lessonId);
}
