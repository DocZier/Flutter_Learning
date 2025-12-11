import '../../../../core/models/fllashcards/flashcards_model.dart';

class StudyState {
  final String deckTitle;
  final bool isFlipped;
  final List<FlashcardModel> dueCards;
  final FlashcardModel? currentCard;
  final int remainingCards;
  final int totalCards;
  final bool isComplete;

  StudyState({
    required this.deckTitle,
    required this.isFlipped,
    required this.dueCards,
    required this.currentCard,
    required this.remainingCards,
    required this.totalCards,
    this.isComplete = false,
  });

  StudyState copyWith({
    String? deckTitle,
    bool? isFlipped,
    List<FlashcardModel>? dueCards,
    FlashcardModel? currentCard,
    int? remainingCards,
    int? totalCards,
    bool? isComplete,
  }) {
    return StudyState(
      deckTitle: deckTitle ?? this.deckTitle,
      isFlipped: isFlipped ?? this.isFlipped,
      dueCards: dueCards ?? this.dueCards,
      currentCard: currentCard ?? this.currentCard,
      remainingCards: remainingCards ?? this.remainingCards,
      totalCards: totalCards ?? this.totalCards,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}