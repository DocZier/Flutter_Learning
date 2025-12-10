import '../../domain/entities/lesson_entity.dart';
import '../sources/local/lessons_local_source.dart';
import '../sources/remote/lessons_remote_source.dart';

abstract class LessonsRepository {
  Future<List<LessonEntity>> getLessons({String? level, int? userId});
  Future<LessonEntity> getLessonById(int id);
  int getLessonPageIndex(int userId, int lessonId);
  void saveLessonPageIndex(int userId, int lessonId, int pageIndex);
  bool isLessonCompleted(int userId, int lessonId);
  void markLessonCompleted(int userId, int lessonId);
  DateTime? getLessonCompletedDate(int userId, int lessonId);
  List<LessonEntity> getLessonsForReview(int userId);
  void clearUserProgress(int userId);
}

class LessonsRepositoryImpl extends LessonsRepository {
  final LessonsRemoteDataSource remoteDataSource;
  final LessonsLocalDataSource localDataSource;

  LessonsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<LessonEntity>> getLessons({String? level, int? userId}) async {
    try {
      final lessons = await remoteDataSource.getLessons(level: level, userId: userId);
      return lessons;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<LessonEntity> getLessonById(int id) async {
    try {
      final lesson = await remoteDataSource.getLessonById(id);
      return lesson;
    } catch (e) {
      throw Exception('Lesson not found');
    }
  }

  @override
  int getLessonPageIndex(int userId, int lessonId) {
    final pageIndex = remoteDataSource.getLessonPageIndex(userId, lessonId);
    localDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
    return pageIndex;
  }

  @override
  void saveLessonPageIndex(int userId, int lessonId, int pageIndex) {
    remoteDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
    localDataSource.saveLessonPageIndex(userId, lessonId, pageIndex);
  }

  @override
  bool isLessonCompleted(int userId, int lessonId) {
    final completed = remoteDataSource.isLessonCompleted(userId, lessonId);
    if (completed) {
      localDataSource.markLessonCompleted(userId, lessonId);
    }
    return completed;
  }

  @override
  void markLessonCompleted(int userId, int lessonId) {
    remoteDataSource.markLessonCompleted(userId, lessonId);
    localDataSource.markLessonCompleted(userId, lessonId);
  }

  @override
  DateTime? getLessonCompletedDate(int userId, int lessonId) {
    return remoteDataSource.getLessonCompletedDate(userId, lessonId);
  }

  @override
  List<LessonEntity> getLessonsForReview(int userId) {
    return remoteDataSource.getLessonsForReview(userId);
  }

  @override
  void updateReviewInterval(int userId, int lessonId, bool correct) {
    remoteDataSource.updateReviewInterval(userId, lessonId, correct);
  }

  @override
  void clearUserProgress(int userId) {
    remoteDataSource.clearUserProgress(userId);
    localDataSource.clearUserProgress(userId);
  }
}
