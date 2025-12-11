import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/remote/dto/flashcard_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/flashcard_mapper.dart';

class FlashcardsRemoteSource {
  static final List<FlashcardRemoteDto> _remoteFlashcards = [];

  Future<List<FlashcardModel>> getFlashcardsByDeckId(String deckId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _remoteFlashcards
        .where((item) => item.deckId == deckId)
        .map((dto) => dto.toModel())
        .toList();
  }

  Future<void> saveFlashcard(FlashcardModel flashcard) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _remoteFlashcards.indexWhere((item) => item.id == flashcard.id);
    if (index != -1) {
      _remoteFlashcards[index] = flashcard.toRemoteDto();
    } else {
      _remoteFlashcards.add(flashcard.toRemoteDto());
    }
  }

  Future<void> removeFlashcard(String deckId, String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _remoteFlashcards.removeWhere(
          (item) => item.id == id && item.deckId == deckId,
    );
  }

  Future<void> removeFlashcardsByDeckId(String deckId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _remoteFlashcards.removeWhere((item) => item.deckId == deckId);
  }
}