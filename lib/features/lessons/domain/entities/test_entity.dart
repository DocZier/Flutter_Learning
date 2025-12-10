class TestEntity {
  final int id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String shortTheory;
   final String   translation;

  const TestEntity({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.shortTheory,
    required this.translation,
  });

  TestEntity copyWith({
    int? id,
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    String? shortTheory,
    String? translation,
  }) {
    return TestEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      shortTheory: shortTheory ?? this.shortTheory,
      translation:  translation ?? this.translation,
    );
  }

}
