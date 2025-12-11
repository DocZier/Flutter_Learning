import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_deck_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_user_decks_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_deck_usecase.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';
import '../states/deck_state.dart';
import 'package:test_practic/core/models/fllashcards/deck_model.dart';

part 'deck_provider.g.dart';

@riverpod
class DeckNotifier extends _$DeckNotifier {
  late final GetUsersDecksUseCase _getUsersDecksUseCase;
  late final SaveDeckUseCase _saveDeckUseCase;
  late final RemoveDeckUseCase _removeDeckUseCase;
  late final GetFlashcardsByDeckIdUseCase _getFlashcardsByDeckIdUseCase;
  late final int _userId;

  @override
  DeckState build() {
    _getUsersDecksUseCase = GetIt.I<GetUsersDecksUseCase>();
    _saveDeckUseCase = GetIt.I<SaveDeckUseCase>();
    _removeDeckUseCase = GetIt.I<RemoveDeckUseCase>();
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();

    final authState = ref.watch(authProvider);
    _userId = (authState as Authenticated).user.id;
    final decks = _loadDecks(_userId);

    return DeckState(
      decks: decks,
      isLoading: false,
    );
  }

  List<Deck> _loadDecks(int userId) {
    final list = _getUsersDecksUseCase.execute(userId);
    return list.map(Deck.fromEntity).toList();
  }

  Future<void> addDeck(Deck deck) async {
    try {
      await _saveDeckUseCase.execute(deck.toEntity());
    } catch (e) {
      throw Exception("Не удалось создать колоду: $e");
    } finally {
      _reload();
    }
  }

  Future<void> removeDeck(String deckId) async {
    try {
      await _removeDeckUseCase.execute(_userId, deckId);
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
    final flashcards = _getFlashcardsByDeckIdUseCase.execute(deckId);
    return flashcards.map(Flashcard.fromEntity).toList();
  }
}