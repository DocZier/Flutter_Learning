
import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/datasources/local/lessons_local_source.dart';
import 'package:test_practic/data/datasources/remote/lessons_remote_source.dart';

abstract class LessonsRepository {
  Future<List<LessonModel>> getLessons({String? level, int? userId});
  Future<LessonModel> getLessonById(int id);
  int getLessonPageIndex(int userId, int lessonId);
  void saveLessonPageIndex(int userId, int lessonId, int pageIndex);
  bool isLessonCompleted(int userId, int lessonId);
  void markLessonCompleted(int userId, int lessonId);
  DateTime? getLessonCompletedDate(int userId, int lessonId);
  List<LessonModel> getLessonsForReview(int userId);
  void clearUserProgress(int userId);
}

class LessonsRepositoryImpl implements LessonsRepository {
  final LessonsRemoteDataSource _remoteDataSource;
  final LessonsLocalDataSource _localDataSource;

  LessonsRepositoryImpl({
    required LessonsRemoteDataSource remoteDataSource,
    required LessonsLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<List<LessonModel>> getLessons({String? level, int? userId}) async {
    try {
      return await _remoteDataSource.getLessons(level: level, userId: userId);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<LessonModel> getLessonById(int id) async {
    try {
      return await _remoteDataSource.getLessonById(id);
    } catch (e) {
      throw Exception('Lesson not found');
    }
  }

  @override
  int getLessonPageIndex(int userId, int lessonId) {
    final pageIndex = _remoteDataSource.getLessonPageIndex(userId, lessonId);
    _localDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
    return pageIndex;
  }

  @override
  void saveLessonPageIndex(int userId, int lessonId, int pageIndex) {
    _remoteDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
    _localDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
  }

  @override
  bool isLessonCompleted(int userId, int lessonId) {
    final completed = _remoteDataSource.isLessonCompleted(userId, lessonId);
    if (completed) {
      _localDataSource.markLessonCompleted(userId, lessonId);
    }
    return completed;
  }

  @override
  void markLessonCompleted(int userId, int lessonId) {
    _remoteDataSource.markLessonCompleted(userId, lessonId);
    _localDataSource.markLessonCompleted(userId, lessonId);
  }

  @override
  DateTime? getLessonCompletedDate(int userId, int lessonId) {
    return _remoteDataSource.getLessonCompletedDate(userId, lessonId);
  }

  @override
  List<LessonModel> getLessonsForReview(int userId) {
    return _remoteDataSource.getLessonsForReview(userId);
  }

  @override
  void updateReviewInterval(int userId, int lessonId, bool correct) {
    _remoteDataSource.updateReviewInterval(userId, lessonId, correct);
  }

  @override
  void clearUserProgress(int userId) {
    _remoteDataSource.clearUserProgress(userId);
    _localDataSource.clearUserProgress(userId);
  }
}