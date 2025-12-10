
import '../../../domain/entities/lesson_entity.dart';
import '../../model/lesson_model.dart';

class LessonsRemoteDataSource {
  static final List<Map<String, dynamic>> _lessons = [
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
      ]
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
      ]
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
      ]
    },
  ];

  Future<List<LessonEntity>> getLessons({String? level}) async {

    final filtered = level == null
        ? _lessons
        : _lessons.where((l) => l['level'] == level).toList();

    return filtered.map((json) {
      final pages = List<Map<String, dynamic>>.from(json['theory_pages'] as List);
      final theoryCombined = pages.map((p) => '${p['title']}\n\n${p['description']}').join('\n\n---\n\n');

      return LessonModel(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        theory: theoryCombined,
          level: json['level'] as String
      ).toEntity();
    }).toList();
  }

  Future<LessonEntity> getLessonById(int id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final json = _lessons.firstWhere((l) => l['id'] == id, orElse: () => throw Exception('Lesson not found'));
    final pages = List<Map<String, dynamic>>.from(json['theory_pages'] as List);
    final theoryCombined = pages.map((p) => '${p['title']}\n\n${p['description']}').join('\n\n---\n\n');

    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      theory: theoryCombined,
        level: json['level'] as String
    ).toEntity();
  }
}
