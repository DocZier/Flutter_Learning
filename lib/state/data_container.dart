import 'package:flutter/cupertino.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/models/flashcards.dart';

class AppData with ChangeNotifier{
  final List<Deck> decks = [];

  void deleteDeck(String id){
      decks.removeWhere((deck) => deck.id == id);
      notifyListeners();
  }

  void addDeck(Deck newDeck){
      decks.add(newDeck);
      notifyListeners();
  }

  void deleteCard(String deckId, String cardId){
      decks.where((deck) => deck.id == deckId).first.flashcards.
      removeWhere((card) => card.id == cardId);
      notifyListeners();
  }

  void updateCard(Flashcard card, int quality){
      card.updateCard(quality);
      notifyListeners();
  }

  void addCard(String deckId, Flashcard card){
      decks.where((deck) => deck.id == deckId).first.flashcards.add(card);
      notifyListeners();
  }
}