import '../../../data/model/deck_model.dart';

class DeckState {
  final List<Deck> decks;
  final bool isLoading;

  DeckState({
    required this.decks,
    required this.isLoading,
  });

  DeckState copyWith({
    List<Deck>? decks,
    bool? isLoading,
  }) {
    return DeckState(
      decks: decks ?? this.decks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
