import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';

import '../../../../core/models/fllashcards/deck_model.dart';

class DeckDetailState {
  final Deck deck;
  final List<Flashcard> flashcards;
  final bool isLoading;

  DeckDetailState({
    required this.deck,
    required this.isLoading,
    required this.flashcards
  });

  DeckDetailState copyWith({
   Deck? deck,
    bool? isLoading,
    List<Flashcard>? flashcards
  }) {
    return DeckDetailState(
      deck: deck ?? this.deck,
      isLoading: isLoading ?? this.isLoading,
      flashcards: flashcards ?? this.flashcards,
    );
  }
}