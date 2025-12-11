
import '../../../domain/entities/deck_entity.dart';

class DeckRemoteSource {
  static final List<Map<String, dynamic>> _remoteDecks = [];

  Future<List<DeckEntity>> getUsersDecks(int userId) async {
    return _remoteDecks.where((item) => item['userId'] == userId).map(_mapToEntity).toList();
  }

  Future<void> saveDeck(DeckEntity deck) async {
    final index = _remoteDecks.indexWhere(
          (item) => item['id'] == deck.id,
    );
    if (index != -1) {
      _remoteDecks[index] = {
        'userId': deck.userId,
        'id': deck.id,
        'title': deck.title,
        'description': deck.description,
      };
    } else {
      _remoteDecks.add({
        'userId': deck.userId,
        'id': deck.id,
        'title': deck.title,
        'description': deck.description,
      });
    }
  }

  Future<void> removeDeck(int userId, String id) async {
    _remoteDecks.removeWhere((item) => item['id'] == id && item['userId'] == userId);
  }

  Future<void> removeDecksByUserId(int userId) async {
    _remoteDecks.removeWhere((item) => item['userId'] == userId);
  }

  DeckEntity _mapToEntity(Map<String, dynamic> map) {
    return DeckEntity(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}