import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class GetFlashcardsByDeckIdUseCase {
  final FlashcardRepository repository;

  GetFlashcardsByDeckIdUseCase(this.repository);

  Future<List<FlashcardModel>> execute(String deckId) async {
    return await repository.getFlashcardsByDeckId(deckId);
  }
}