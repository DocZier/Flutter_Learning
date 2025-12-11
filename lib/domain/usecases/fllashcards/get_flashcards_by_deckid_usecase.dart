import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class GetFlashcardsByDeckIdUseCase {
  final FlashcardRepository repository;

  GetFlashcardsByDeckIdUseCase(this.repository);

  List<FlashcardModel> execute(String deckId) {
    return repository.getFlashcardsByDeckId(deckId);
  }
}