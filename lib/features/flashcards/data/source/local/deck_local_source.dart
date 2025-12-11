
import '../../../domain/entities/deck_entity.dart';

class DeckLocalSource {
  static final List<Map<String, dynamic>> _localDecks = [];

  void saveDeck(DeckEntity deck) {
    final index = _localDecks.indexWhere(
          (item) => item['id'] == deck.id,
    );
    if (index != -1) {
      _localDecks[index] = {
        'userId': deck.userId,
        'id': deck.id,
        'title': deck.title,
        'description': deck.description,
      };
    } else {
      _localDecks.add({
        'userId': deck.userId,
        'id': deck.id,
        'title': deck.title,
        'description': deck.description,
      });
    }
  }

  void removeDeck(String id) {
    _localDecks.removeWhere((item) => item['id'] == id);
  }

  void removeDecksByUserId(int userId) {
    _localDecks.removeWhere((item) => item['userId'] == userId);
  }

  DeckEntity getDeck(int userId, String id) {
    final index = _localDecks.indexWhere(
          (item) => item['id'] == id && item['userId'] == userId,
    );
    return _mapToEntity(_localDecks[index]);
  }

  List<DeckEntity> getUsersDecks(int userId) {
    return _localDecks.where((item) => item['userId'] == userId).map(_mapToEntity).toList();
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