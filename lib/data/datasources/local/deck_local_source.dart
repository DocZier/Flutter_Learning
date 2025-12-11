import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/local/dto/deck_dto.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/deck_mapper.dart';

class DeckLocalSource {
  static final List<DeckLocalDto> _localDecks = [];

  void saveDeck(DeckModel deck) {
    final index = _localDecks.indexWhere((item) => item.id == deck.id);
    if (index != -1) {
      _localDecks[index] = deck.toLocalDto();
    } else {
      _localDecks.add(deck.toLocalDto());
    }
  }

  void removeDeck(String id) {
    _localDecks.removeWhere((item) => item.id == id);
  }

  void removeDecksByUserId(int userId) {
    _localDecks.removeWhere((item) => item.userId == userId);
  }

  DeckModel getDeck(int userId, String id) {
    final deckDto = _localDecks.firstWhere(
          (item) => item.id == id && item.userId == userId,
    );
    return deckDto.toModel();
  }

  List<DeckModel> getUsersDecks(int userId) {
    return _localDecks
        .where((item) => item.userId == userId)
        .map((dto) => dto.toModel())
        .toList();
  }
}