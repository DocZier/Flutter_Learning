class TestLocalDto {
  final int id;
  final int lessonId;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String shortTheory;
  final String translation;
  final DateTime? nextReviewDate;

  TestLocalDto({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.shortTheory,
    required this.translation,
    this.nextReviewDate,
  });

  factory TestLocalDto.fromJson(Map<String, dynamic> json) {
    return TestLocalDto(
      id: json['id'],
      lessonId: json['lessonId'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
      shortTheory: json['shortTheory'],
      translation: json['translation'],
      nextReviewDate: json['nextReviewDate'] != null
          ? DateTime.parse(json['nextReviewDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'shortTheory': shortTheory,
      'translation': translation,
      'nextReviewDate': nextReviewDate?.toIso8601String(),
    };
  }
}