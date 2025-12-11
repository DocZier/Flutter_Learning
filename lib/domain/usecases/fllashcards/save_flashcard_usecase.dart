import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class SaveFlashcardUseCase {
  final FlashcardRepository repository;

  SaveFlashcardUseCase(this.repository);

  Future<void> execute(FlashcardModel flashcard) async {
    await repository.saveFlashcard(flashcard);
  }
}