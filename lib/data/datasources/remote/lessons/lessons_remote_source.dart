import '../../../../core/models/lessons/lesson_entity.dart';

class LessonsRemoteDataSource {
  static final List<Map<String, dynamic>> _lessonsData = [
    {
      'id': 1,
      'level': 'N5',
      'title': 'Genki I — Урок 1: Знакомство',
      'description': 'Базовые фразы приветствия и представления.',
      'theory_pages': [
        {
          'title': 'はじめまして',
          'description': 'Фраза для первого знакомства. Используется при знакомстве.'
        },
        {
          'title': 'お名前は？',
          'description': 'Вопрос о имени. Примеры: わたしの名前は〜です。'
        }
      ],
    },
    {
      'id': 2,
      'level': 'N5',
      'title': 'Genki I — Урок 2: Семья',
      'description': 'Слова про членов семьи, основные выражения.',
      'theory_pages': [
        {
          'title': 'かぞく',
          'description': 'Семья — как описывать членов семьи и их профессии.'
        }
      ],
    },
    {
      'id': 3,
      'level': 'N4',
      'title': 'Genki II — Урок 1: Путешествия',
      'description': 'Основы разговорной лексики для поездок.',
      'theory_pages': [
        {
          'title': 'りょこう',
          'description': 'Как говорить о поездках и билетах.'
        }
      ],
    },
  ];

  static final Map<int, Map<int, Map<String, dynamic>>> _userLessonsProgress = {};

  Future<List<LessonEntity>> getLessons({String? level, int? userId}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final filteredLessons = level == null
        ? _lessonsData
        : _lessonsData.where((l) => l['level'] == level).toList();

    return filteredLessons.map((json) {
      final pages = List<Map<String, dynamic>>.from(json['theory_pages'] as List);
      final theoryCombined = pages.map((p) => '${p['title']}\n${p['description']}').join('\n---\n');

      bool completed = false;
      DateTime? nextReviewDate;

      if (userId != null && _userLessonsProgress.containsKey(userId)) {
        final userProgress = _userLessonsProgress[userId]![json['id'] as int];
        if (userProgress != null) {
          completed = userProgress['completed'] as bool;
          if (userProgress['nextReviewDate'] != null) {
            nextReviewDate = DateTime.parse(userProgress['nextReviewDate'] as String);
          }
        }
      }

      return LessonEntity(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        theory: theoryCombined,
        level: json['level'] as String,
        completed: completed,
        nextReviewDate: nextReviewDate,
      );
    }).toList();
  }

  Future<LessonEntity> getLessonById(int id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final json = _lessonsData.firstWhere((l) => l['id'] == id, orElse: () => throw Exception('Lesson not found'));
    final pages = List<Map<String, dynamic>>.from(json['theory_pages'] as List);
    final theoryCombined = pages.map((p) => '${p['title']}\n${p['description']}').join('\n---\n');

    return LessonEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      theory: theoryCombined,
      level: json['level'] as String,
      completed: false,
      nextReviewDate: null,
    );
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

  List<LessonEntity> getLessonsForReview(int userId) {
    final allLessons = _lessonsData.map((json) {
      final pages = List<Map<String, dynamic>>.from(json['theory_pages'] as List);
      final theoryCombined = pages.map((p) => '${p['title']}\n${p['description']}').join('\n---\n');

      return LessonEntity(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        theory: theoryCombined,
        level: json['level'] as String,
        completed: false,
        nextReviewDate: null,
      );
    }).toList();

    if (!_userLessonsProgress.containsKey(userId)) {
      return [];
    }

    final now = DateTime.now();
    final lessonsToReview = <LessonEntity>[];

    for (final lesson in allLessons) {
      if (_userLessonsProgress[userId]!.containsKey(lesson.id)) {
        final progress = _userLessonsProgress[userId]![lesson.id]!;
        final completed = progress['completed'] as bool? ?? false;
        final nextReviewDateStr = progress['nextReviewDate'] as String?;

        if (completed && nextReviewDateStr != null) {
          final nextReviewDate = DateTime.parse(nextReviewDateStr);
          if (nextReviewDate.isBefore(now)) {
            lessonsToReview.add(lesson.copyWith(
              completed: true,
              nextReviewDate: nextReviewDate,
            ));
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
