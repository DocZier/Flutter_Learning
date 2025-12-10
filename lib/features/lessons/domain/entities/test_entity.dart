class TestEntity {
  final int id;
  final int lessonId;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String shortTheory;
  final String translation;
  final DateTime? nextReviewDate;

  const TestEntity({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.shortTheory,
    required this.translation,
    this.nextReviewDate,
  });

  TestEntity copyWith({
    int? id,
    int? lessonId,
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    String? shortTheory,
    String? translation,
    DateTime? nextReviewDate,
  }) {
    return TestEntity(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      question: question ?? this.question,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      shortTheory: shortTheory ?? this.shortTheory,
      translation: translation ?? this.translation,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
    );
  }
}