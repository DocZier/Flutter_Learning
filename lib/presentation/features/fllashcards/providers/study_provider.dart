import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_deck_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_flashcard_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/update_flashcard_usecase.dart';
import 'package:test_practic/presentation/features/fllashcards/providers/deck_flashcards_provider.dart';
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
  Future<StudyState> build(String deckId) async {
    _getDeckByIdUseCase = GetIt.I<GetDeckByIdUseCase>();
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();
    _applyQualityUseCase = GetIt.I<UpdateFlashcardUseCase>();

    final authStateAsync = ref.watch(authProvider);
    if (authStateAsync is! AsyncData<AuthState> ||
        authStateAsync.value is! Authenticated) {
      throw Exception('Пользователь не авторизован');
    }

    final authState = authStateAsync.value as Authenticated;
    _userId = authState.user.id;

    final deck = await _getDeckByIdUseCase.execute(_userId, deckId);
    final flashcards = await _loadFlashcards(deckId);
    final dueCards = flashcards
        .where(
          (c) => c.nextReview.difference(DateTime.now()).inMilliseconds <= 0,
        )
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

  Future<List<FlashcardModel>> _loadFlashcards(String deckId) async {
    return await _getFlashcardsByDeckIdUseCase.execute(deckId);
  }

  void flip() {
    state = AsyncValue.data(
      state.value!.copyWith(isFlipped: !state.value!.isFlipped),
    );
  }

  void setCurrentCard(FlashcardModel? card) {
    state = AsyncValue.data(state.value!.copyWith(currentCard: card));
  }

  Future<void> updateDueCards(String deckId) async {
    final flashcards = await _loadFlashcards(deckId);
    final dueCards = flashcards
        .where(
          (c) => c.nextReview.difference(DateTime.now()).inMilliseconds <= 0,
        )
        .toList();
    state = AsyncValue.data(
      state.value!.copyWith(
        dueCards: dueCards,
        remainingCards: dueCards.length,
      ),
    );
    ref.read(deckFlashcardsProvider(deckId).notifier).refresh();
  }

  Future<void> updateCard(int quality, String deckId) async {
    final card = state.value!.currentCard;
    if (card == null) return;

    flip();
    final updated = _applyQualityUseCase.execute(card, quality);
    await GetIt.I<SaveFlashcardUseCase>().execute(updated);

    final newDue = List<FlashcardModel>.from(state.value!.dueCards);
    newDue.removeWhere((c) => c.id == card.id);

    if (newDue.isNotEmpty) {
      final nextCard = newDue.first;
      state = AsyncValue.data(
        state.value!.copyWith(
          dueCards: newDue,
          currentCard: nextCard,
          remainingCards: newDue.length,
          isFlipped: false,
        ),
      );
    } else {
      state = AsyncValue.data(
        state.value!.copyWith(
          currentCard: null,
          remainingCards: 0,
          isComplete: true,
        ),
      );
    }
    ref.read(deckFlashcardsProvider(deckId).notifier).refresh();
  }

  void resetSession() {
    state = AsyncValue.data(
      state.value!.copyWith(
        isFlipped: false,
        isComplete: false,
        currentCard: state.value!.dueCards.isNotEmpty
            ? state.value!.dueCards.first
            : null,
        remainingCards: state.value!.dueCards.length,
      ),
    );
  }
}
