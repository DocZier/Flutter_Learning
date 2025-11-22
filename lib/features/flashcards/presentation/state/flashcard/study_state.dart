import '../../../data/model/flashcards_model.dart';

class StudyState {
  final String deckTitle;
  final bool isFlipped;
  final List<Flashcard> dueCards;
  final Flashcard? currentCard;

  StudyState({
    required this.deckTitle,
    required this.isFlipped,
    required this.dueCards,
    required this.currentCard,
  });

  StudyState copyWith({
    String? deckTitle,
    bool? isFlipped,
    List<Flashcard>? dueCards,
    Flashcard? currentCard,
  }) {
    return StudyState(
      deckTitle: deckTitle ?? this.deckTitle,
      isFlipped: isFlipped ?? this.isFlipped,
      dueCards: dueCards ?? this.dueCards,
      currentCard: currentCard ?? this.currentCard,
    );
  }
}