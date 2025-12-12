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
  Future<DeckState> build() async {
    _getUsersDecksUseCase = GetIt.I<GetUsersDecksUseCase>();
    _saveDeckUseCase = GetIt.I<SaveDeckUseCase>();
    _removeDeckUseCase = GetIt.I<RemoveDeckUseCase>();
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();

    final authStateAsync = ref.watch(authProvider);
    if (authStateAsync is! AsyncData<AuthState> ||
        authStateAsync.value is! Authenticated) {
      throw Exception('Пользователь не авторизован');
    }

    final authState = authStateAsync.value as Authenticated;
    _userId = authState.user.id;

    final decks = await _loadDecks(_userId);
    return DeckState(
      decks: decks,
      isLoading: false,
    );
  }

  Future<List<DeckModel>> _loadDecks(int userId) async {
    final list = _getUsersDecksUseCase.execute(userId);
    return list;
  }

  Future<void> addDeck(DeckModel deck) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _saveDeckUseCase.execute(deck);
      await _reload();
    } catch (e) {
      throw Exception("Не удалось создать колоду: $e");
    }
  }

  Future<void> removeDeck(String deckId) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _removeDeckUseCase.execute(_userId, deckId);
      await _reload();
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }
  }

  Future<void> _reload() async {
    final decks = await _loadDecks(_userId);
    state = AsyncValue.data(
      state.value!.copyWith(
        decks: decks,
        isLoading: false,
      ),
    );
  }

  bool isEmpty() {
    return state.value?.decks.isEmpty ?? true;
  }

  List<FlashcardModel> getFlashcardsByDeckId(String deckId) {
    final flashcards = _getFlashcardsByDeckIdUseCase.execute(deckId);
    return flashcards;
  }
}