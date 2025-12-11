class LessonsLocalDataSource {
  static final Map<int, Map<int, int>> _cachedPageIndexes = {};
  static final Map<int, Map<int, bool>> _cachedCompletedStatus = {};

  int getLessonPageIndex(int userId, int lessonId) {
    return _cachedPageIndexes[userId]?[lessonId] ?? 0;
  }

  void saveLessonPageIndex(int userId, int lessonId, int pageIndex) {
    _cachedPageIndexes.putIfAbsent(userId, () => {});
    _cachedPageIndexes[userId]![lessonId] = pageIndex;
  }

  bool isLessonCompleted(int userId, int lessonId) {
    return _cachedCompletedStatus[userId]?[lessonId] ?? false;
  }

  void markLessonCompleted(int userId, int lessonId) {
    _cachedCompletedStatus.putIfAbsent(userId, () => {});
    _cachedCompletedStatus[userId]![lessonId] = true;
  }

  void clearUserProgress(int userId) {
    _cachedPageIndexes.remove(userId);
    _cachedCompletedStatus.remove(userId);
  }
}