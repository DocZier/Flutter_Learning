import 'package:test_practic/state/data_container.dart';
import '../models/decks.dart';
import '../models/flashcards.dart';

abstract class AppDataRepository {
  void deleteDeck(String id);
  void addDeck(Deck newDeck);
  void deleteCard(String deckId, String cardId);
  void updateCard(Flashcard card, int quality);
  void addCard(String deckId, Flashcard card);
}

class AppDataRepositoryImpl implements AppDataRepository {
  final AppData appData;

  AppDataRepositoryImpl({required this.appData});

  @override
  void deleteDeck(String id) {
    appData.decks.removeWhere((deck) => deck.id == id);
  }

  @override
  void addDeck(Deck newDeck) {
    appData.decks.add(newDeck);
  }

  @override
  void deleteCard(String deckId, String cardId) {
    appData.decks
        .where((deck) => deck.id == deckId)
        .first
        .flashcards
        .removeWhere((card) => card.id == cardId);
  }

  @override
  void updateCard(Flashcard card, int quality) {
    card.updateCard(quality);
  }

  @override
  void addCard(String deckId, Flashcard card) {
    appData.decks.where((deck) => deck.id == deckId).first.flashcards.add(card);
  }
}
