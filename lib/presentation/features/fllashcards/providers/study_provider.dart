import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_deck_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_flashcard_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/update_flashcard_usecase.dart';
import 'package:test_practic/presentation/shared/states/auth_state.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../../core/models/fllashcards/flashcards_model.dart';
import '../states/study_state.dart';

part 'study_provider.g.dart';

@riverpod
class StudyNotifier extends _$StudyNotifier {
  late final GetDeckByIdUseCase _getDeckByIdUseCase;
  late final GetFlashcardsByDeckIdUseCase _getFlashcardsByDeckIdUseCase;
  late final UpdateFlashcardUseCase _applyQualityUseCase;
  late final int _userId;

  @override
  StudyState build(String deckId) {
    _getDeckByIdUseCase = GetIt.I<GetDeckByIdUseCase>();
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();
    _applyQualityUseCase = GetIt.I<UpdateFlashcardUseCase>();

    final authState = ref.watch(authProvider);
    _userId = (authState as Authenticated).user.id;

    final deck = _getDeckByIdUseCase.execute(_userId, deckId);
    final flashcards = _loadFlashcards(deckId);
    final dueCards = flashcards
        .where((c) => c.nextReview.difference(DateTime.now()).inMilliseconds <= 0)
        .toList();

    return StudyState(
      deckTitle: deck.title,
      isFlipped: false,
      dueCards: dueCards,
      currentCard: dueCards.isNotEmpty ? dueCards.first : null,
      remainingCards: dueCards.length,
      totalCards: flashcards.length,
    );
  }

  List<Flashcard> _loadFlashcards(String deckId) {
    return _getFlashcardsByDeckIdUseCase.execute(deckId).map(Flashcard.fromEntity).toList();
  }

  void flip() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void setCurrentCard(Flashcard? card) {
    state = state.copyWith(currentCard: card);
  }

  Future<void> updateDueCards(String deckId) async {
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
    final updated = _applyQualityUseCase.execute(card.toEntity(), quality);
    await GetIt.I<SaveFlashcardUseCase>().execute(updated);

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