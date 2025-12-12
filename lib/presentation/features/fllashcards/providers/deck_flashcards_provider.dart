import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';

part 'deck_flashcards_provider.g.dart';

@riverpod
class DeckFlashcards extends _$DeckFlashcards {
  late final GetFlashcardsByDeckIdUseCase _getFlashcardsByDeckIdUseCase;

  @override
  Future<List<FlashcardModel>> build(String deckId) async {
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();
    return await _getFlashcardsByDeckIdUseCase.execute(deckId);
  }

  void refresh() async {
    state = AsyncValue.data(await _getFlashcardsByDeckIdUseCase.execute(deckId));
  }
}