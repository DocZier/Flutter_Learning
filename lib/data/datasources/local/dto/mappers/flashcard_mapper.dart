import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';

extension FlashcardLocalMapper on Flashcard {
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
  Flashcard toLocalDto() {
    return Flashcard(
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