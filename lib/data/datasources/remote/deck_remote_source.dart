import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/remote/dto/deck_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/deck_mapper.dart';

class DeckRemoteSource {
  static final List<DeckRemoteDto> _remoteDecks = [];

  Future<List<DeckModel>> getUsersDecks(int userId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _remoteDecks
        .where((item) => item.userId == userId)
        .map((dto) => dto.toModel())
        .toList();
  }

  Future<void> saveDeck(DeckModel deck) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _remoteDecks.indexWhere((item) => item.id == deck.id);
    if (index != -1) {
      _remoteDecks[index] = deck.toRemoteDto();
    } else {
      _remoteDecks.add(deck.toRemoteDto());
    }
  }

  Future<void> removeDeck(int userId, String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _remoteDecks.removeWhere((item) => item.id == id && item.userId == userId);
  }

  Future<void> removeDecksByUserId(int userId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _remoteDecks.removeWhere((item) => item.userId == userId);
  }
}