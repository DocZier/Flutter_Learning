import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/shared/state/auth_state.dart';

import '../../../../../shared/providers/auth_provider.dart';
import '../../../data/model/flashcards_model.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../state/flashcard/study_state.dart';

part 'study_provider.g.dart';

@riverpod
class StudyNotifier extends _$StudyNotifier {
  late final FlashcardRepository _repo;
  late final int _userId;

  @override
  StudyState build(String deckId) {
    final authState = ref.watch(authProvider);
    _userId = (authState as Authenticated).user.id;
    _repo = GetIt.I<FlashcardRepository>();

    final title = _repo.getDeckById(_userId, deckId).title;
    final flashcards = _loadFlashcards(deckId);

    final dueCards = flashcards
        .where((c) => c.nextReview.difference(DateTime.now()).inMilliseconds <= 0)
        .toList();

    return StudyState(
      deckTitle: title,
      isFlipped: false,
      dueCards: dueCards,
      currentCard: dueCards.isNotEmpty ? dueCards.first : null,
      remainingCards: dueCards.length,
      totalCards: flashcards.length,
    );
  }

  List<Flashcard> _loadFlashcards(String deckId) {
    return _repo
        .getFlashcardsByDeckId(deckId)
        .map(Flashcard.fromEntity)
        .toList();
  }

  void flip() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void setCurrentCard(Flashcard? card) {
    state = state.copyWith(currentCard: card);
  }

  Future<void> updateDueCards() async {
    final flashcards = _loadFlashcards(deckId);
    final dueCards = flashcards
        .where((c) => c.nextReview.difference(DateTime.now()).inMilliseconds <= 0)
        .toList();

    state = state.copyWith(
      dueCards: dueCards,
      remainingCards: dueCards.length,
    );
  }

  Future<void> updateCard(int quality, String deckId) async {
    final card = state.currentCard;
    if (card == null) return;
    flip();
    final updated = _repo.applyQuality(card.toEntity(), quality);
    await _repo.saveFlashcard(updated);

    final newDue = List<Flashcard>.from(state.dueCards);
    newDue.removeWhere((c) => c.id == card.id);
    if (newDue.isNotEmpty) {
      final nextCard = newDue.first;
      state = state.copyWith(
        dueCards: newDue,
        currentCard: nextCard,
        remainingCards: newDue.length,
        isFlipped: false,
      );
    } else {
      state = state.copyWith(
        currentCard: null,
        remainingCards: 0,
        isComplete: true,
      );
    }
  }

  void resetSession() {
    state = state.copyWith(
      isFlipped: false,
      isComplete: false,
      currentCard: state.dueCards.isNotEmpty ? state.dueCards.first : null,
      remainingCards: state.dueCards.length,
    );
  }
}