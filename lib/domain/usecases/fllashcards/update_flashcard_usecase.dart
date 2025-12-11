import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class UpdateFlashcardUseCase {
  final FlashcardRepository repository;

  UpdateFlashcardUseCase(this.repository);

  FlashcardModel execute(FlashcardModel entity, int quality) {
    return repository.applyQuality(entity, quality);
  }
}