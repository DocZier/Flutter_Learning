
import '../../../domain/entities/lesson_entity.dart';
import '../../model/lesson_model.dart';

class LessonsLocalDataSource {
  static final Map<int, int> _lessonProgress = {};

  static final Set<int> _completedLessons = {};

  int getLessonPageIndex(int lessonId) {
    return _lessonProgress[lessonId] ?? 0;
  }

  void saveLessonPageIndex(int lessonId, int pageIndex) {
    _lessonProgress[lessonId] = pageIndex;
  }

  bool isLessonCompleted(int lessonId) {
    return _completedLessons.contains(lessonId);
  }

  void markLessonCompleted(int lessonId) {
    _completedLessons.add(lessonId);
  }

  void unmarkLessonCompleted(int lessonId) {
    _completedLessons.remove(lessonId);
  }

  void clearAllProgress() {
    _lessonProgress.clear();
    _completedLessons.clear();
  }
}