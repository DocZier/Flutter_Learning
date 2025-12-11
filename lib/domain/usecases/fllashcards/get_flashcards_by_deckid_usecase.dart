import 'package:test_practic/core/models/fllashcards/flashcard_entity.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class GetFlashcardsByDeckIdUseCase {
  final FlashcardRepository repository;

  GetFlashcardsByDeckIdUseCase(this.repository);

  List<FlashcardEntity> execute(String deckId) {
    return repository.getFlashcardsByDeckId(deckId);
  }
}