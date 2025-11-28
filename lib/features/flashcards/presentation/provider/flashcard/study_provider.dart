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

  @override
  StudyState build(String deckId) {
    _repo = GetIt.I<FlashcardRepository>();

    final title = _repo.getDeckById(
        (ref.read(authProvider) as Authenticated).user.id,
        deckId
    ).title;
    final flashcards = _loadFlashcards(deckId);
    final dueCards = flashcards
        .where((c) => c.nextReview.isBefore(DateTime.now()))
        .toList();

    return StudyState(
      deckTitle: title,
      isFlipped: false,
      dueCards: dueCards,
      currentCard: dueCards.isNotEmpty ? dueCards.first : null,
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

  void updateDueCards() {
    state = state.copyWith(dueCards: state.dueCards.where((c) => c.nextReview.isBefore(DateTime.now()))
        .toList());
  }

  Future<void> updateCard(int quality, String deckId) async {
    final card = state.currentCard;
    if (card == null) return;

    flip();

    final updated = _repo.applyQuality(card.toEntity(), quality);
    await _repo.saveFlashcard(updated);

    final newDue = [...state.dueCards];
    newDue.removeWhere((c) => c.id == card.id);

    final nextCard = newDue.isNotEmpty ? newDue.first : null;

    state = state.copyWith(
      dueCards: newDue,
      currentCard: nextCard,
    );
  }
}