import 'package:test_practic/core/models/fllashcards/flashcard_entity.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class UpdateFlashcardUseCase {
  final FlashcardRepository repository;

  UpdateFlashcardUseCase(this.repository);

  FlashcardEntity execute(FlashcardEntity entity, int quality) {
    return repository.applyQuality(entity, quality);
  }
}