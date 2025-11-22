import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/flashcards/data/model/flashcards_model.dart';

import '../../../../../shared/providers/auth_provider.dart';
import '../../../../../shared/state/auth_state.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../state/deck/deck_state.dart';
import 'package:test_practic/features/flashcards/data/model/deck_model.dart';

part 'deck_provider.g.dart';

@riverpod
class DeckNotifier extends _$DeckNotifier {
  late final FlashcardRepository _repo;

  @override
  DeckState build() {
    _repo = GetIt.I<FlashcardRepository>();

    final userId = (ref.read(authProvider) as Authenticated).user.id;
    final decks = _loadDecks(userId);

    return DeckState(
      decks: decks,
      isLoading: false,
    );
  }

  List<Deck> _loadDecks(int userId) {
    final list = _repo.getUsersDecks(userId);
    return list.map(Deck.fromEntity).toList();
  }

  Future<void> addDeck(Deck deck) async {
    state = state.copyWith(isLoading: true);

    try {
      await _repo.saveDeck(deck.toEntity());
      await _reloadDecks();
    } catch (e) {
      throw Exception("Не удалось создать колоду: $e");
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> removeDeck(String deckId) async {
    state = state.copyWith(isLoading: true);

    final userId = (ref.read(authProvider) as Authenticated).user.id;

    try {
      await _repo.removeDeck(userId, deckId);
      await _reloadDecks();
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> _reloadDecks() async {
    final userId = (ref.read(authProvider) as Authenticated).user.id;
    final decks = _loadDecks(userId);

    state = state.copyWith(decks: decks);
  }

  bool isEmpty() {
    return state.decks.isEmpty;
  }

  List<Flashcard> getFlashcardsByDeckId(String deckId) {
    final flashcards =  _repo.getFlashcardsByDeckId(deckId);
    return flashcards.map(Flashcard.fromEntity).toList();
  }
}