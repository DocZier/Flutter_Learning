
import 'package:test_practic/features/lessons/domain/entities/test_entity.dart';

import '../../model/test_model.dart';

class TestsRemoteDataSource {
  static final Map<int, List<Map<String, dynamic>>> _tests = {
    1: [
      {
        'id': '1',
        'sentence': 'これは ____ です。',
        'options': ['ほん', 'ねこ', 'たべる'],
        'correct': 0,
        'short_theory': 'です — вежливая связка “быть”.',
        'translation': 'Это книга.'
      },
      {
        'id': '2',
        'sentence': 'あなたは ____ ですか？',
        'options': ['せんせい', 'みず', 'たべる'],
        'correct': 0,
        'short_theory': 'Вопросительная форма с か.',
        'translation': 'Вы учитель?'
      },
      {
        'id': '3',
        'sentence': 'ねこは ____ です。',
        'options': ['かわいい', 'ほん', 'おおきい'],
        'correct': 0,
        'short_theory': 'Прилагательное かわいい — милый(ая).',
        'translation': 'Кот милый.'
      },
    ],
    2: [
      {
        'id': '1',
        'sentence': 'これは ____ の しゃしん です。',
        'options': ['わたし', 'にほん', 'くるま'],
        'correct': 2,
        'short_theory': 'の — показатель принадлежности.',
        'translation': 'Это фотография машины.'
      }
    ],
    3: [
      {
        'id': '1',
        'sentence': 'くうこう は どこ ____ か？',
        'options': ['に', 'で', 'を'],
        'correct': 0,
        'short_theory': 'に — указание направления/места.',
        'translation': 'Где аэропорт?'
      }
    ],
  };

  Future<List<TestEntity>> getQuestionsForLesson(int lessonId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final list = _tests[lessonId] ?? [];
    return list.map((q) {
      return TestEntity(
        id: int.parse(q['id'] as String),
        question: q['sentence'] as String,
        options: List<String>.from(q['options'] as List),
        correctOptionIndex: q['correct'] as int,
        shortTheory: q['short_theory'] as String,
        translation: q['translation'] as String,
      );
    }).toList();
  }

  Future<TestEntity> getQuestionById(int lessonId, int questionId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final list = _tests[lessonId] ?? [];
    final q = list.firstWhere((m) => int.parse(m['id'] as String) == questionId, orElse: () => throw Exception('Question not found'));
    return TestEntity(
      id: int.parse(q['id'] as String),
      question: q['sentence'] as String,
      options: List<String>.from(q['options'] as List),
      correctOptionIndex: q['correct'] as int,
      shortTheory: q['short_theory'] as String,
      translation: q['translation'] as String,
    );
  }
}
