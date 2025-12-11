import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/dto/flashcard_dto.dart';

extension FlashcardLocalMapper on FlashcardLocalDto {
  FlashcardModel toModel() {
    return FlashcardModel(
      deckId: deckId,
      id: id,
      question: question,
      answer: answer,
      interval: interval,
      easeFactor: easeFactor,
      nextReview: nextReview,
      reviewCount: reviewCount,
      lastReviewedAt: lastReviewedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension FlashcardModelLocalMapper on FlashcardModel {
  FlashcardLocalDto toLocalDto() {
    return FlashcardLocalDto(
      deckId: deckId,
      id: id,
      question: question,
      answer: answer,
      interval: interval,
      easeFactor: easeFactor,
      nextReview: nextReview,
      reviewCount: reviewCount,
      lastReviewedAt: lastReviewedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}