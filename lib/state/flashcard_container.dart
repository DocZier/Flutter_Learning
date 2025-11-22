import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/models/flashcards.dart';
import 'package:test_practic/features/flashcard/screens/study_screen.dart';
import 'package:test_practic/features/flashcard/screens/add_flashcard_screen.dart';
import 'package:test_practic/features/deck/screens/deck_list_screen.dart';
import 'package:test_practic/features/deck/screens/deck_detail_screen.dart';

enum Screen {list, form, study, view}

/*
class FlashcardContainer extends StatefulWidget{
  const FlashcardContainer({super.key});

  @override
  State<FlashcardContainer> createState() => _FlashcardContainerState();
}

class _FlashcardContainerState extends State<FlashcardContainer> {
  final List<Deck> _decks = [];
  String _currentDeck = "";
  Screen _currentScreen = Screen.list;

  void _navigateToList() {
    setState(() => _currentScreen = Screen.list);
  }

  void _navigateToForm(String deckId) {
    setState(() {
      _currentScreen = Screen.form;
      _currentDeck = deckId;
    });
  }

  void _navigateToStudy(String deckId) {
    setState(() {
      _currentScreen = Screen.study;
      _currentDeck = deckId;
    });
  }

  void _navigateToView(String deckId) {
    setState(() {
      _currentScreen = Screen.view;
      _currentDeck = deckId;
    });
  }

  void _deleteDeck(String id){
    setState(() {
      _currentScreen = Screen.list;
      _decks.removeWhere((deck) => deck.id == id);
    });
  }

  void _addDeck(Deck newDeck){
    setState(() {
      _decks.add(newDeck);
    });
  }

  void _deleteCard(String deckId, String cardId){
    setState(() {
      _decks.where((deck) => deck.id == deckId).first.flashcards.
      removeWhere((card) => card.id == cardId);
    });
  }

  void _updateCard(Flashcard card, int quality){
    setState(() {
      card.updateCard(quality);
    });
  }

  void _addCard(String deckId, Flashcard card){
    setState(() {
      _decks.where((deck) => deck.id == deckId).first.flashcards.add(card);
    });
  }


  @override
  Widget build(BuildContext context) {
    switch(_currentScreen) {
      case Screen.list:
        return HomeScreen(
          decks: _decks,
          addDeck: (Deck newDeck) => _addDeck(newDeck),
          onTapEmpty: (deckId) => _navigateToForm(deckId),
          onTapFull: (deckId) => _navigateToStudy(deckId),
          onLongPress: (deckId) => _navigateToView(deckId),
        );
      case Screen.study:
        return StudyScreen(
          deck: _decks.where((deck) => deck.id == _currentDeck).first,
          updateCard: (Flashcard card, int quality) => _updateCard(card, quality),
          navigateToList: () => _navigateToList(),
        );
      case Screen.form:
        return AddCardScreen(
          deckId: _currentDeck,
          addCard: (String deckId, Flashcard card) => _addCard(deckId, card),
          navigateToList: () => _navigateToList(),
        );
      case Screen.view:
        return DeckDetailsScreen(
          deck: _decks.where((deck) => deck.id == _currentDeck).first,
          navigateToForm: (deckId) => _navigateToForm(deckId),
          navigateToStudy: (deckId) => _navigateToStudy(deckId),
          deleteCard: (String deckId, String cardId) => _deleteCard(deckId, cardId),
          deleteDeck: (String deckId) => _deleteDeck(deckId),
        );
    }
  }
}*/
