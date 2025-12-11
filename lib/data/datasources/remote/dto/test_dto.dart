class TestRemoteDto {
  final int id;
  final int lessonId;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String shortTheory;
  final String translation;

  TestRemoteDto({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.shortTheory,
    required this.translation,
  });

  factory TestRemoteDto.fromJson(Map<String, dynamic> json) {
    return TestRemoteDto(
      id: json['id'],
      lessonId: json['lessonId'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correct'],
      shortTheory: json['short_theory'],
      translation: json['translation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'question': question,
      'options': options,
      'correct': correctOptionIndex,
      'short_theory': shortTheory,
      'translation': translation,
    };
  }
}