
import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/test_mapper.dart';
import 'package:test_practic/data/datasources/remote/dto/test_dto.dart';

class TestsRemoteDataSource {
  static final Map<int, List<TestRemoteDto>> _allTests = {
    1: [
      TestRemoteDto(
        id: 1,
        lessonId: 1,
        question: 'これは ____ です。',
        options: ['ほん', 'ねこ', 'たべる'],
        correctOptionIndex: 0,
        shortTheory: 'です — вежливая связка "быть".',
        translation: 'Это книга.',
      ),
      TestRemoteDto(
        id: 2,
        lessonId: 1,
        question: 'あなたは ____ ですか？',
        options: ['せんせい', 'みず', 'たべる'],
        correctOptionIndex: 0,
        shortTheory: 'Вопросительная форма с か.',
        translation: 'Вы учитель?',
      ),
      TestRemoteDto(
        id: 3,
        lessonId: 1,
        question: 'ねこは ____ です。',
        options: ['かわいい', 'ほん', 'おおきい'],
        correctOptionIndex: 0,
        shortTheory: 'Прилагательное かわいい — милый(ая).',
        translation: 'Кот милый.',
      ),
    ],
    2: [
      TestRemoteDto(
        id: 4,
        lessonId: 2,
        question: 'これは ____ の しゃしん です。',
        options: ['わたし', 'にほん', 'くるま'],
        correctOptionIndex: 2,
        shortTheory: 'の — показатель принадлежности.',
        translation: 'Это фотография машины.',
      )
    ],
    3: [
      TestRemoteDto(
        id: 5,
        lessonId: 3,
        question: 'くうこう は どこ ____ か？',
        options: ['に', 'で', 'を'],
        correctOptionIndex: 0,
        shortTheory: 'に — указание направления/места.',
        translation: 'Где аэропорт?',
      )
    ],
  };

  static final Map<int, Map<int, Map<String, int>>> _userStats = {};
  static final Map<int, List<TestModel>> _userReviewQueue = {};

  Future<List<TestModel>> getQuestionsForLesson(int lessonId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final questions = _allTests[lessonId] ?? [];
    return questions.map((dto) => dto.toModel()).toList();
  }

  List<TestModel> getDueReviewQuestions(int userId, int lessonId) {
    final now = DateTime.now();
    final dueQuestions = <TestModel>[];
    if (_userReviewQueue.containsKey(userId)) {
      for (final q in _userReviewQueue[userId]!) {
        if (q.lessonId == lessonId && q.nextReviewDate != null) {
          if (q.nextReviewDate!.isBefore(now)) {
            dueQuestions.add(q);
          }
        }
      }
    }
    return dueQuestions;
  }

  void addToReviewQueue(int userId, TestModel question, {int interval = 1}) {
    _userReviewQueue.putIfAbsent(userId, () => []);
    final existingIndex = _userReviewQueue[userId]!
        .indexWhere((q) => q.id == question.id && q.lessonId == question.lessonId);

    final nextReviewDate = DateTime.now().add(Duration(days: interval));
    final questionWithDate = question.copyWith(nextReviewDate: nextReviewDate);

    if (existingIndex != -1) {
      _userReviewQueue[userId]![existingIndex] = questionWithDate;
    } else {
      _userReviewQueue[userId]!.add(questionWithDate);
    }
  }

  void updateReviewInterval(int userId, int questionId, bool correct) {
    if (!_userReviewQueue.containsKey(userId)) return;

    final questionIndex = _userReviewQueue[userId]!
        .indexWhere((q) => q.id == questionId);

    if (questionIndex == -1) return;

    final question = _userReviewQueue[userId]![questionIndex];
    final currentNextReviewDate = question.nextReviewDate ?? DateTime.now();
    final daysSinceLastReview = DateTime.now().difference(currentNextReviewDate).inDays;
    int currentInterval = daysSinceLastReview > 0 ? daysSinceLastReview : 1;

    final newInterval = correct
        ? (currentInterval < 2 ? 2 : currentInterval * 2)
        : 1;

    final newNextReviewDate = DateTime.now().add(Duration(days: newInterval));

    _userReviewQueue[userId]![questionIndex] = question.copyWith(
      nextReviewDate: newNextReviewDate,
    );
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