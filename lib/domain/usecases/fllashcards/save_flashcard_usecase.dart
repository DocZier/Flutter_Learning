import 'package:test_practic/core/models/fllashcards/flashcard_entity.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class SaveFlashcardUseCase {
  final FlashcardRepository repository;

  SaveFlashcardUseCase(this.repository);

  Future<void> execute(FlashcardEntity flashcard) async {
    await repository.saveFlashcard(flashcard);
  }
}