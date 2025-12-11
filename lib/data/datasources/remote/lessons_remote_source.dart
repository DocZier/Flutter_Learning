
import 'package:test_practic/core/models/lessons/lesson_model.dart';
import 'package:test_practic/data/datasources/remote/dto/lesson_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/lesson_mapper.dart';

class LessonsRemoteDataSource {
  static final List<LessonRemoteDto> _lessonsData = [
    LessonRemoteDto(
      id: 1,
      level: 'N5',
      title: 'Genki I — Урок 1: Знакомство',
      description: 'Базовые фразы приветствия и представления.',
      theoryPages: [
        {
          'title': 'はじめまして',
          'description': 'Фраза для первого знакомства. Используется при знакомстве.'
        },
        {
          'title': 'お名前は？',
          'description': 'Вопрос о имени. Примеры: わたしの名前は〜です。'
        }
      ],
    ),
    LessonRemoteDto(
      id: 2,
      level: 'N5',
      title: 'Genki I — Урок 2: Семья',
      description: 'Слова про членов семьи, основные выражения.',
      theoryPages: [
        {
          'title': 'かぞく',
          'description': 'Семья — как описывать членов семьи и их профессии.'
        }
      ],
    ),
    LessonRemoteDto(
      id: 3,
      level: 'N4',
      title: 'Genki II — Урок 1: Путешествия',
      description: 'Основы разговорной лексики для поездок.',
      theoryPages: [
        {
          'title': 'りょこう',
          'description': 'Как говорить о поездках и билетах.'
        }
      ],
    ),
  ];

  static final Map<int, Map<int, Map<String, dynamic>>> _userLessonsProgress = {};

  Future<List<LessonModel>> getLessons({String? level, int? userId}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final filteredLessons = level == null
        ? _lessonsData
        : _lessonsData.where((l) => l.level == level).toList();
    return filteredLessons.map((dto) {
      bool completed = false;
      DateTime? nextReviewDate;
      if (userId != null && _userLessonsProgress.containsKey(userId)) {
        final userProgress = _userLessonsProgress[userId]![dto.id];
        if (userProgress != null) {
          completed = userProgress['completed'] as bool;
          if (userProgress['nextReviewDate'] != null) {
            nextReviewDate = DateTime.parse(userProgress['nextReviewDate'] as String);
          }
        }
      }
      return dto.toModel(completed: completed, nextReviewDate: nextReviewDate);
    }).toList();
  }

  Future<LessonModel> getLessonById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final dto = _lessonsData.firstWhere(
          (l) => l.id == id,
      orElse: () => throw Exception('Lesson not found'),
    );
    return dto.toModel(completed: false, nextReviewDate: null);
  }

  void markLessonCompleted(int userId, int lessonId) {
    _userLessonsProgress.putIfAbsent(userId, () => {});
    _userLessonsProgress[userId]!.putIfAbsent(lessonId, () => {
      'completed': false,
      'pageIndex': 0,
      'completedDate': null,
      'nextReviewDate': null,
    });
    final now = DateTime.now();
    final nextReviewDate = now.add(const Duration(days: 1));
    _userLessonsProgress[userId]![lessonId]!['completed'] = true;
    _userLessonsProgress[userId]![lessonId]!['completedDate'] = now.toIso8601String();
    _userLessonsProgress[userId]![lessonId]!['nextReviewDate'] = nextReviewDate.toIso8601String();
  }

  void saveLessonPageIndex(int userId, int lessonId, int pageIndex) {
    _userLessonsProgress.putIfAbsent(userId, () => {});
    _userLessonsProgress[userId]!.putIfAbsent(lessonId, () => {
      'completed': false,
      'pageIndex': 0,
      'completedDate': null,
      'nextReviewDate': null,
    });
    _userLessonsProgress[userId]![lessonId]!['pageIndex'] = pageIndex;
  }

  int getLessonPageIndex(int userId, int lessonId) {
    if (_userLessonsProgress.containsKey(userId) &&
        _userLessonsProgress[userId]!.containsKey(lessonId)) {
      return _userLessonsProgress[userId]![lessonId]!['pageIndex'] as int? ?? 0;
    }
    return 0;
  }

  bool isLessonCompleted(int userId, int lessonId) {
    if (_userLessonsProgress.containsKey(userId) &&
        _userLessonsProgress[userId]!.containsKey(lessonId)) {
      return _userLessonsProgress[userId]![lessonId]!['completed'] as bool? ?? false;
    }
    return false;
  }

  DateTime? getLessonCompletedDate(int userId, int lessonId) {
    if (_userLessonsProgress.containsKey(userId) &&
        _userLessonsProgress[userId]!.containsKey(lessonId) &&
        _userLessonsProgress[userId]![lessonId]!['completedDate'] != null) {
      return DateTime.parse(_userLessonsProgress[userId]![lessonId]!['completedDate'] as String);
    }
    return null;
  }

  List<LessonModel> getLessonsForReview(int userId) {
    if (!_userLessonsProgress.containsKey(userId)) {
      return [];
    }
    final now = DateTime.now();
    final lessonsToReview = <LessonModel>[];
    for (final lesson in _lessonsData) {
      if (_userLessonsProgress[userId]!.containsKey(lesson.id)) {
        final progress = _userLessonsProgress[userId]![lesson.id]!;
        final completed = progress['completed'] as bool? ?? false;
        final nextReviewDateStr = progress['nextReviewDate'] as String?;
        if (completed && nextReviewDateStr != null) {
          final nextReviewDate = DateTime.parse(nextReviewDateStr);
          if (nextReviewDate.isBefore(now)) {
            lessonsToReview.add(
              lesson.toModel(completed: true, nextReviewDate: nextReviewDate),
            );
          }
        }
      }
    }
    return lessonsToReview;
  }

  void updateReviewInterval(int userId, int lessonId, bool correct) {
    if (!_userLessonsProgress.containsKey(userId) ||
        !_userLessonsProgress[userId]!.containsKey(lessonId)) {
      return;
    }
    final progress = _userLessonsProgress[userId]![lessonId]!;
    final currentNextReviewDate = progress['nextReviewDate'] != null
        ? DateTime.parse(progress['nextReviewDate'] as String)
        : DateTime.now();
    final daysSinceLastReview = DateTime.now().difference(currentNextReviewDate).inDays;
    int currentInterval = daysSinceLastReview > 0 ? daysSinceLastReview : 1;
    final newInterval = correct
        ? (currentInterval < 2 ? 2 : currentInterval * 2)
        : 1;
    final newNextReviewDate = DateTime.now().add(Duration(days: newInterval));
    progress['nextReviewDate'] = newNextReviewDate.toIso8601String();
  }

  void clearUserProgress(int userId) {
    _userLessonsProgress.remove(userId);
  }
}