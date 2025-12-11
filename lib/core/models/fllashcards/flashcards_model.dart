
import 'flashcard_entity.dart';

class Flashcard extends FlashcardEntity {
  const Flashcard({
    required super.deckId,
    required super.id,
    required super.question,
    required super.answer,
    required super.interval,
    required super.nextReview,
    required super.easeFactor,
    required super.reviewCount,
    required super.lastReviewedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  FlashcardEntity toEntity() => FlashcardEntity(
    deckId: deckId,
    id: id,
    question: question,
    answer: answer,
    interval: interval,
    nextReview: nextReview,
    easeFactor: easeFactor,
    reviewCount: reviewCount,
    lastReviewedAt: lastReviewedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory Flashcard.fromEntity(FlashcardEntity entity) => Flashcard(
    deckId: entity.deckId,
    id: entity.id,
    question: entity.question,
    answer: entity.answer,
    interval: entity.interval,
    nextReview: entity.nextReview,
    easeFactor: entity.easeFactor,
    reviewCount: entity.reviewCount,
    lastReviewedAt: entity.lastReviewedAt,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
  );

  @override
  Flashcard copyWith({
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
    return Flashcard(
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