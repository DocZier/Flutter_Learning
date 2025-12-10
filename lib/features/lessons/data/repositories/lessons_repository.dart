import '../../domain/entities/lesson_entity.dart';
import '../sources/local/lessons_local_source.dart';
import '../sources/remote/lessons_remote_source.dart';

abstract class LessonsRepository {
  Future<List<LessonEntity>> getLessons({String? level});
  Future<LessonEntity> getLessonById(int id);
  int getLessonPageIndex(int lessonId);
  void saveLessonPageIndex(int lessonId, int pageIndex);
  bool isLessonCompleted(int lessonId);
  void markLessonCompleted(int lessonId);
  void unmarkLessonCompleted(int lessonId);
  void clearAllProgress();
}

class LessonsRepositoryImpl extends LessonsRepository {
  final LessonsRemoteDataSource remoteDataSource;
  final LessonsLocalDataSource localDataSource;

  LessonsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<LessonEntity>> getLessons({String? level}) async {
    try {
      final lessons = await remoteDataSource.getLessons(level: level);
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
  int getLessonPageIndex(int lessonId) => localDataSource.getLessonPageIndex(lessonId);

  @override
  void saveLessonPageIndex(int lessonId, int pageIndex) => localDataSource.saveLessonPageIndex(lessonId, pageIndex);

  @override
  bool isLessonCompleted(int lessonId) => localDataSource.isLessonCompleted(lessonId);

  @override
  void markLessonCompleted(int lessonId) => localDataSource.markLessonCompleted(lessonId);

  @override
  void unmarkLessonCompleted(int lessonId) => localDataSource.unmarkLessonCompleted(lessonId);

  @override
  void clearAllProgress() => localDataSource.clearAllProgress();
}
