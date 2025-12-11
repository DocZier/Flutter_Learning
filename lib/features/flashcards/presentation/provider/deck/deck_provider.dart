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
  late final int _userId;

  @override
  DeckState build() {
    _repo = GetIt.I<FlashcardRepository>();
    final authState = ref.watch(authProvider);
    _userId = (authState as Authenticated).user.id;

    final decks = _loadDecks(_userId);
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
    print('Provider add start');
    try {
      await _repo.saveDeck(deck.toEntity());
    } catch (e) {
      throw Exception("Не удалось создать колоду: $e");
    } finally {
      _reload();
    }
  }

  Future<void> removeDeck(String deckId) async {
    try {
      await _repo.removeDeck(_userId, deckId);
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    } finally {
      _reload();
    }
  }

  void _reload() {
    final decks = _loadDecks(_userId);
    state = state.copyWith(
      decks: decks,
      isLoading: false,
    );
  }

  bool isEmpty() {
    return state.decks.isEmpty;
  }

  List<Flashcard> getFlashcardsByDeckId(String deckId) {
    final flashcards =  _repo.getFlashcardsByDeckId(deckId);
    return flashcards.map(Flashcard.fromEntity).toList();
  }
}