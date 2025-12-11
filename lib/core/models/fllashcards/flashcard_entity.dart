class FlashcardEntity {
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

  const FlashcardEntity({
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

  FlashcardEntity copyWith({
    String? question,
    String? answer,
    int? interval,
    DateTime? nextReview,
    double? easeFactor,
    int? reviewCount,
    DateTime? lastReviewedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FlashcardEntity(
      deckId: deckId,
      id: id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      interval: interval ?? this.interval,
      nextReview: nextReview ?? this.nextReview,
      easeFactor: easeFactor ?? this.easeFactor,
      reviewCount: reviewCount ?? this.reviewCount,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}