
import 'package:test_practic/features/lessons/domain/entities/test_entity.dart';

class TestsLocalDataSource {
  static final Map<int, List<Map<String, dynamic>>> _repeatQueue = {};

  static final Map<int, Map<String, int>> _stats = {};

  List<TestEntity> getRepeatQueue(int lessonId) {
    final list = _repeatQueue[lessonId] ?? [];
    return list.map((m) => _mapToEntity(m)).toList();
  }

  void addToRepeat(int lessonId, TestEntity q) {
    final list = _repeatQueue.putIfAbsent(lessonId, () => []);
    list.add({
      'id': q.id.toString(),
      'question': q.question,
      'options': q.options,
      'correct': q.correctOptionIndex,
      'short_theory': (q as dynamic).shortTheory ?? '',
      'translation': (q as dynamic).translation ?? '',
    });
  }

  void clearRepeatQueue(int lessonId) {
    _repeatQueue.remove(lessonId);
  }

  void addStat(int lessonId, {required bool correct}) {
    final map = _stats.putIfAbsent(lessonId, () => {'total': 0, 'correct': 0});
    map['total'] = (map['total'] ?? 0) + 1;
    if (correct) map['correct'] = (map['correct'] ?? 0) + 1;
  }

  Map<String, int> getStats(int lessonId) {
    return _stats[lessonId] ?? {'total': 0, 'correct': 0};
  }

  TestEntity _mapToEntity(Map<String, dynamic> m) {
    return TestEntity(
      id: int.parse(m['id'] as String),
      question: m['question'] as String,
      options: List<String>.from(m['options'] as List<dynamic>),
      correctOptionIndex: m['correct'] as int,
      shortTheory: m['short_theory'] as String,
      translation: m['translation'] as String,
    );
  }
}
