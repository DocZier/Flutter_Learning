import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';

import '../../../../core/models/fllashcards/deck_model.dart';

class DeckDetailState {
  final DeckModel deck;
  final List<FlashcardModel> flashcards;
  final bool isLoading;

  DeckDetailState({
    required this.deck,
    required this.isLoading,
    required this.flashcards
  });

  DeckDetailState copyWith({
   DeckModel? deck,
    bool? isLoading,
    List<FlashcardModel>? flashcards
  }) {
    return DeckDetailState(
      deck: deck ?? this.deck,
      isLoading: isLoading ?? this.isLoading,
      flashcards: flashcards ?? this.flashcards,
    );
  }
}