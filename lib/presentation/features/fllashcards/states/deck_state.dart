import '../../../../core/models/fllashcards/deck_model.dart';

class DeckState {
  final List<DeckModel> decks;
  final bool isLoading;

  DeckState({
    required this.decks,
    required this.isLoading,
  });

  DeckState copyWith({
    List<DeckModel>? decks,
    bool? isLoading,
  }) {
    return DeckState(
      decks: decks ?? this.decks,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
