
import '../../domain/entities/test_entity.dart';

class TestModel extends TestEntity {
  const TestModel({
    required super.id,
    required super.question,
    required super.options,
    required super.correctOptionIndex,
    required super.shortTheory,
    required super.translation,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correct'],
      shortTheory:  json['short_theory'],
      translation: json['translation'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'options': options,
    'correct': correctOptionIndex,
  };

  factory TestModel.fromEntity(TestEntity entity) {
    return TestModel(
      id: entity.id,
      question: entity.question,
      options: entity.options,
      correctOptionIndex: entity.correctOptionIndex,
      shortTheory: entity.shortTheory,
      translation: entity.translation,
    );
  }

  TestEntity toEntity() => TestEntity(
    id: id,
    question: question,
    options: options,
    correctOptionIndex: correctOptionIndex,
    shortTheory: shortTheory,
    translation: translation,
  );
}
