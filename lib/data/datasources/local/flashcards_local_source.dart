import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/dto/flashcard_dto.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/flashcard_mapper.dart';

class FlashcardsLocalSource {
  static final List<FlashcardLocalDto> _localFlashcards = [];

  void saveFlashcard(FlashcardModel flashcard) {
    final index = _localFlashcards.indexWhere((item) => item.id == flashcard.id);
    if (index != -1) {
      _localFlashcards[index] = flashcard.toLocalDto();
    } else {
      _localFlashcards.add(flashcard.toLocalDto());
    }
  }

  void removeFlashcard(String id) {
    _localFlashcards.removeWhere((item) => item.id == id);
  }

  FlashcardModel getFlashcard(String id) {
    final flashcardDto = _localFlashcards.firstWhere((item) => item.id == id);
    return flashcardDto.toModel();
  }

  List<FlashcardModel> getFlashcardsByDeckId(String deckId) {
    return _localFlashcards
        .where((item) => item.deckId == deckId)
        .map((dto) => dto.toModel())
        .toList();
  }

  void removeFlashcardsByDeckId(String deckId) {
    _localFlashcards.removeWhere((item) => item.deckId == deckId);
  }
}