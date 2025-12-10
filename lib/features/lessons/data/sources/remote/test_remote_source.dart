import 'package:test_practic/features/lessons/domain/entities/test_entity.dart';

class TestsRemoteDataSource {
  static final Map<int, List<Map<String, dynamic>>> _allTests = {
    1: [
      {
        'id': 1,
        'sentence': 'これは ____ です。',
        'options': ['ほん', 'ねこ', 'たべる'],
        'correct': 0,
        'short_theory': 'です — вежливая связка "быть".',
        'translation': 'Это книга.'
      },
      {
        'id': 2,
        'sentence': 'あなたは ____ ですか？',
        'options': ['せんせい', 'みず', 'たべる'],
        'correct': 0,
        'short_theory': 'Вопросительная форма с か.',
        'translation': 'Вы учитель?'
      },
      {
        'id': 3,
        'sentence': 'ねこは ____ です。',
        'options': ['かわいい', 'ほん', 'おおきい'],
        'correct': 0,
        'short_theory': 'Прилагательное かわいい — милый(ая).',
        'translation': 'Кот милый.'
      },
    ],
    2: [
      {
        'id': 4,
        'sentence': 'これは ____ の しゃしん です。',
        'options': ['わたし', 'にほん', 'くるま'],
        'correct': 2,
        'short_theory': 'の — показатель принадлежности.',
        'translation': 'Это фотография машины.'
      }
    ],
    3: [
      {
        'id': 5,
        'sentence': 'くうこう は どこ ____ か？',
        'options': ['に', 'で', 'を'],
        'correct': 0,
        'short_theory': 'に — указание направления/места.',
        'translation': 'Где аэропорт?'
      }
    ],
  };

  static final Map<int, Map<int, Map<String, int>>> _userStats = {};

  static final Map<int, List<Map<String, dynamic>>> _userReviewQueue = {};

  Future<List<TestEntity>> getQuestionsForLesson(int lessonId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final questions = _allTests[lessonId] ?? [];
    return questions.map((q) => TestEntity(
      id: q['id'] as int,
      question: q['sentence'] as String,
      options: List<String>.from(q['options']),
      correctOptionIndex: q['correct'] as int,
      shortTheory: q['short_theory'] as String,
      translation: q['translation'] as String,
      lessonId: lessonId,
      nextReviewDate: null,
    )).toList();
  }

  List<TestEntity> getDueReviewQuestions(int userId, int lessonId) {
    final now = DateTime.now();
    final dueQuestions = <TestEntity>[];

    if (_userReviewQueue.containsKey(userId)) {
      for (final q in _userReviewQueue[userId]!) {
        if (q['lessonId'] == lessonId && q['nextReviewDate'] != null) {
          final nextReviewDate = DateTime.parse(q['nextReviewDate'] as String);
          if (nextReviewDate.isBefore(now)) {
            dueQuestions.add(TestEntity(
              id: q['id'] as int,
              lessonId: q['lessonId'] as int,
              question: q['question'] as String,
              options: List<String>.from(q['options'] as List),
              correctOptionIndex: q['correctOptionIndex'] as int,
              shortTheory: q['shortTheory'] as String,
              translation: q['translation'] as String,
              nextReviewDate: nextReviewDate,
            ));
          }
        }
      }
    }

    return dueQuestions;
  }

  void addToReviewQueue(int userId, TestEntity question, {int interval = 1}) {
    _userReviewQueue.putIfAbsent(userId, () => []);

    final existingIndex = _userReviewQueue[userId]!.indexWhere((q) => q['id'] == question.id);
    final nextReviewDate = DateTime.now().add(Duration(days: interval)).toIso8601String();

    final questionData = {
      'id': question.id,
      'lessonId': question.lessonId,
      'question': question.question,
      'options': question.options,
      'correctOptionIndex': question.correctOptionIndex,
      'shortTheory': question.shortTheory,
      'translation': question.translation,
      'nextReviewDate': nextReviewDate,
    };

    if (existingIndex != -1) {
      _userReviewQueue[userId]![existingIndex] = questionData;
    } else {
      _userReviewQueue[userId]!.add(questionData);
    }
  }

  void updateReviewInterval(int userId, int questionId, bool correct) {
    if (!_userReviewQueue.containsKey(userId)) return;

    final questionIndex = _userReviewQueue[userId]!.indexWhere((q) => q['id'] == questionId);
    if (questionIndex == -1) return;

    final question = _userReviewQueue[userId]![questionIndex];
    final currentNextReviewDate = question['nextReviewDate'] != null
        ? DateTime.parse(question['nextReviewDate'] as String)
        : DateTime.now();

    final daysSinceLastReview = DateTime.now().difference(currentNextReviewDate).inDays;
    int currentInterval = daysSinceLastReview > 0 ? daysSinceLastReview : 1;

    final newInterval = correct
        ? (currentInterval < 2 ? 2 : currentInterval * 2)
        : 1;

    final newNextReviewDate = DateTime.now().add(Duration(days: newInterval));
    question['nextReviewDate'] = newNextReviewDate.toIso8601String();
  }

  void addStat(int userId, int lessonId, {required bool correct}) {
    _userStats.putIfAbsent(userId, () => <int, Map<String, int>>{});
    final userStats = _userStats[userId]!;

    if (!userStats.containsKey(lessonId)) {
      userStats[lessonId] = <String, int>{'total': 0, 'correct': 0};
    }

    final lessonStats = userStats[lessonId]!;
    lessonStats['total'] = (lessonStats['total'] ?? 0) + 1;
    if (correct) {
      lessonStats['correct'] = (lessonStats['correct'] ?? 0) + 1;
    }
  }

  Map<String, dynamic> getUserStats(int userId) {
    if (!_userStats.containsKey(userId)) {
      return {
        'byLesson': <int, Map<String, int>>{},
        'total': {'total': 0, 'correct': 0},
        'accuracy': 0
      };
    }

    final userStats = _userStats[userId]!;
    final totalStats = {'total': 0, 'correct': 0};

    userStats.forEach((lessonId, lessonStats) {
      totalStats['total'] = (totalStats['total'] as int) + (lessonStats['total'] as int);
      totalStats['correct'] = (totalStats['correct'] as int) + (lessonStats['correct'] as int);
    });

    final accuracy = totalStats['total'] != 0
        ? ((totalStats['correct'] as int) / (totalStats['total'] as int) * 100).round()
        : 0;

    return {
      'byLesson': Map<int, Map<String, int>>.from(userStats),
      'total': Map<String, int>.from(totalStats),
      'accuracy': accuracy,
    };
  }

  void clearUserProgress(int userId) {
    _userStats.remove(userId);
    _userReviewQueue.remove(userId);
  }
}
