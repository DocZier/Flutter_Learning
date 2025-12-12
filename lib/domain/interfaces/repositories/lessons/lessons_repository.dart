
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