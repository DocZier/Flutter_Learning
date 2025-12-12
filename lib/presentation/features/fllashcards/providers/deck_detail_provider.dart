import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_deck_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_flashcard_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_deck_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';
import '../../../../core/models/fllashcards/deck_model.dart';
import '../../../../core/models/fllashcards/flashcards_model.dart';
import '../states/deck_detail_state.dart';

part 'deck_detail_provider.g.dart';

@riverpod
class DeckDetailNotifier extends _$DeckDetailNotifier {
  late final GetDeckByIdUseCase _getDeckByIdUseCase;
  late final GetFlashcardsByDeckIdUseCase _getFlashcardsByDeckIdUseCase;
  late final RemoveDeckUseCase _removeDeckUseCase;
  late final RemoveFlashcardUseCase _removeFlashcardUseCase;
  late final RemoveFlashcardsByDeckIdUseCase _removeFlashcardsByDeckIdUseCase;
  late final int _userId;

  @override
  Future<DeckDetailState> build(String deckId) async {
    _getDeckByIdUseCase = GetIt.I<GetDeckByIdUseCase>();
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();
    _removeDeckUseCase = GetIt.I<RemoveDeckUseCase>();
    _removeFlashcardUseCase = GetIt.I<RemoveFlashcardUseCase>();
    _removeFlashcardsByDeckIdUseCase = GetIt.I<RemoveFlashcardsByDeckIdUseCase>();

    final authStateAsync = ref.watch(authProvider);
    if (authStateAsync is! AsyncData<AuthState> ||
        authStateAsync.value is! Authenticated) {
      throw Exception('Пользователь не авторизован');
    }

    final authState = authStateAsync.value as Authenticated;
    _userId = authState.user.id;

    final deck = await _loadDeck(_userId, deckId);
    final flashcards = await _loadFlashcards(deckId);

    return DeckDetailState(
      deck: deck,
      flashcards: flashcards,
      isLoading: false,
    );
  }

  Future<DeckModel> _loadDeck(int userId, String deckId) async {
    final deck = await _getDeckByIdUseCase.execute(userId, deckId);
    return deck;
  }

  Future<List<FlashcardModel>> _loadFlashcards(String deckId) async {
    return (await _getFlashcardsByDeckIdUseCase.execute(deckId)).toList();
  }

  Future<void> deleteDeck(String deckId) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _removeDeckUseCase.execute(_userId, deckId);
      await _removeFlashcardsByDeckIdUseCase.execute(deckId);
      await _reload(deckId);
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> removeFlashcard(String deckId, String flashcardId) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      await _removeFlashcardUseCase.execute(deckId, flashcardId);
      await _reload(deckId);
    } catch (e) {
      throw Exception("Ошибка удаления: $e");
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> _reload(String deckId) async {
    final updatedDeck = await _loadDeck(_userId, deckId);
    final updatedFlashcards = await _loadFlashcards(deckId);
    state = AsyncValue.data(
      state.value!.copyWith(
        deck: updatedDeck,
        flashcards: updatedFlashcards,
      ),
    );
  }
}