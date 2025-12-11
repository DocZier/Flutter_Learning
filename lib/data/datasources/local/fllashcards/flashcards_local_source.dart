
import 'package:test_practic/core/models/fllashcards/flashcard_entity.dart';

class FlashcardsLocalSource {
  static final List<Map<String, dynamic>> _localFlashcards = [];

  void saveFlashcard(FlashcardEntity flashcard) {
    final index = _localFlashcards.indexWhere(
          (item) => item['id'] == flashcard.id,
    );
    if (index != -1) {
      _localFlashcards[index] = {
        'deckId': flashcard.deckId,
        'id': flashcard.id,
        'question': flashcard.question,
        'answer': flashcard.answer,
        'interval': flashcard.interval,
        'nextReview': flashcard.nextReview.toIso8601String(),
        'easeFactor': flashcard.easeFactor,
        'reviewCount': flashcard.reviewCount,
        'lastReviewedAt': flashcard.lastReviewedAt.toIso8601String(),
        'createdAt': flashcard.createdAt.toIso8601String(),
        'updatedAt': flashcard.updatedAt.toIso8601String(),
      };
    } else {
      _localFlashcards.add({
        'deckId': flashcard.deckId,
        'id': flashcard.id,
        'question': flashcard.question,
        'answer': flashcard.answer,
        'interval': flashcard.interval,
        'nextReview': flashcard.nextReview.toIso8601String(),
        'easeFactor': flashcard.easeFactor,
        'reviewCount': flashcard.reviewCount,
        'lastReviewedAt': flashcard.lastReviewedAt.toIso8601String(),
        'createdAt': flashcard.createdAt.toIso8601String(),
        'updatedAt': flashcard.updatedAt.toIso8601String(),
      });
    }
  }

  void removeFlashcard(String id) {
    _localFlashcards.removeWhere((item) => item['id'] == id);
  }

  FlashcardEntity getFlashcard(String id) {
    final index = _localFlashcards.indexWhere((item) => item['id'] == id);
    return _mapToEntity(_localFlashcards[index]);
  }

  List<FlashcardEntity> getFlashcardsByDeckId(String deckId) {
    return _localFlashcards.where((item) => item['deckId'] == deckId).map(_mapToEntity).toList();
  }

  void removeFlashcardsByDeckId(String deckId) {
    _localFlashcards.removeWhere((item) => item['deckId'] == deckId);
  }

  FlashcardEntity _mapToEntity(Map<String, dynamic> map) {
    return FlashcardEntity(
      deckId: map['deckId'],
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      interval: map['interval'],
      nextReview: DateTime.parse(map['nextReview']),
      easeFactor: map['easeFactor'],
      reviewCount: map['reviewCount'],
      lastReviewedAt: DateTime.parse(map['lastReviewedAt']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}