import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/remote/dto/flashcard_dto.dart';

extension FlashcardRemoteMapper on FlashcardRemoteDto {
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

extension FlashcardModelRemoteMapper on FlashcardModel {
  FlashcardRemoteDto toRemoteDto() {
    return FlashcardRemoteDto(
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