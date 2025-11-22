import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../shared/providers/auth_provider.dart';
import '../../../../../shared/state/auth_state.dart';
import '../../../data/model/deck_model.dart';
import '../../../data/model/flashcards_model.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../state/deck/deck_detail_state.dart';
import '../../state/deck/deck_state.dart';

part 'deck_detail_provider.g.dart';

@riverpod
class DeckDetailNotifier extends _$DeckDetailNotifier {
  late final FlashcardRepository _repo;

  @override
  Future<DeckDetailState> build(String deckId) async {
    _repo = GetIt.I<FlashcardRepository>();

    final userId = (ref.read(authProvider) as Authenticated).user.id;
    final deck = _loadDeck(userId, deckId);
    final flashcards = _loadFlashcards(deck.id);


    return DeckDetailState(
      deck: deck,
      flashcards: flashcards,
      isLoading: false,
    );
  }

  Deck _loadDeck(int userId, String deckId) {
    final deck = _repo.getDeckById(userId, deckId);
    return Deck.fromEntity(deck);
  }

  List<Flashcard> _loadFlashcards(String deckId) {
    return _repo
        .getFlashcardsByDeckId(deckId)
        .map(Flashcard.fromEntity)
        .toList();
  }

  Future<void> deleteDeck(int userId,String deckId) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));

    try {
      await _repo.removeDeck(userId, deckId);
      await _reload(deckId);
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }

    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> removeFlashcard(String deckId, String flashcardId) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));

    try {
      await _repo.removeFlashcard(deckId, flashcardId);
      await _reload(deckId);
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }

    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> _reload(String deckId) async {
    final userId = (ref.read(authProvider) as Authenticated).user.id;

    final updatedDeck = _loadDeck(userId, deckId);
    final updatedFlashcards = _loadFlashcards(deckId);

    state = AsyncValue.data(
      state.value!.copyWith(
        deck: updatedDeck,
        flashcards: updatedFlashcards,
      ),
    );
  }
}