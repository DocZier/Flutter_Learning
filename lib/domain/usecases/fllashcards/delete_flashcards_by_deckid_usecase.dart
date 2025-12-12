import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class RemoveFlashcardsByDeckIdUseCase {
  final FlashcardRepository repository;

  RemoveFlashcardsByDeckIdUseCase(this.repository);

  Future<void> execute(String deckId) async {
    await repository.removeFlashcardsByDeckId(deckId);
  }
}