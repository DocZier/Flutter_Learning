import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class RemoveFlashcardUseCase {
  final FlashcardRepository repository;

  RemoveFlashcardUseCase(this.repository);

  Future<void> execute(String deckId, String id) async {
    await repository.removeFlashcard(deckId, id);
  }
}