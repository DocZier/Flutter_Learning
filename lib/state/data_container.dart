import 'package:test_practic/models/decks.dart';
import 'package:test_practic/models/flashcards.dart';

class AppData {
  final List<Deck> decks = [];

  Flashcard getCard(String deckId, String cardId) {
    return decks
        .where((deck) => deck.id == deckId)
        .first
        .flashcards
        .where((card) => card.id == cardId)
        .first;
  }

  Deck getDeckById(String id) {
    return decks.where((deck) => deck.id == id).first;
  }

  Deck getDeckByIndex(int index) {
    return decks[index];
  }

  bool isEmpty() {
    return decks.isEmpty;
  }

  int getLength() {
    return decks.length;
  }
}
