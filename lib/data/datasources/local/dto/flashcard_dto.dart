class FlashcardLocalDto {
  final String deckId;
  final String id;
  final String question;
  final String answer;
  final int interval;
  final DateTime nextReview;
  final double easeFactor;
  final int reviewCount;
  final DateTime lastReviewedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  FlashcardLocalDto({
    required this.deckId,
    required this.id,
    required this.question,
    required this.answer,
    required this.interval,
    required this.easeFactor,
    required this.nextReview,
    required this.reviewCount,
    required this.lastReviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FlashcardLocalDto.fromJson(Map<String, dynamic> json) {
    return FlashcardLocalDto(
      deckId: json['deckId'],
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      interval: json['interval'],
      easeFactor: (json['easeFactor'] as num).toDouble(),
      nextReview: DateTime.parse(json['nextReview']),
      reviewCount: json['reviewCount'],
      lastReviewedAt: DateTime.parse(json['lastReviewedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deckId': deckId,
      'id': id,
      'question': question,
      'answer': answer,
      'interval': interval,
      'easeFactor': easeFactor,
      'nextReview': nextReview.toIso8601String(),
      'reviewCount': reviewCount,
      'lastReviewedAt': lastReviewedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}