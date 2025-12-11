
import 'package:test_practic/core/models/fllashcards/flashcard_entity.dart';

class FlashcardsRemoteSource {
  static final List<Map<String, dynamic>> _remoteFlashcards = [];

  Future<List<FlashcardEntity>> getFlashcardsByDeckId(String deckId) async {
    return _remoteFlashcards.where((item) => item['deckId'] == deckId).map(_mapToEntity).toList();
  }

  Future<void> saveFlashcard(FlashcardEntity flashcard) async {
    final index = _remoteFlashcards.indexWhere(
          (item) => item['id'] == flashcard.id,
    );
    if (index != -1) {
      _remoteFlashcards[index] = {
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
      _remoteFlashcards.add({
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

  Future<void> removeFlashcard(String deckId, String id) async {
    _remoteFlashcards.removeWhere((item) => item['id'] == id && item['deckId'] == deckId);
  }

  Future<void> removeFlashcardsByDeckId(String deckId) async {
    _remoteFlashcards.removeWhere((item) => item['deckId'] == deckId);
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