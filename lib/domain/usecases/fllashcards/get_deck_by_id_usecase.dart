import 'package:test_practic/core/models/fllashcards/deck_entity.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class GetDeckByIdUseCase {
  final FlashcardRepository repository;

  GetDeckByIdUseCase(this.repository);

  DeckEntity execute(int userId, String id) {
    return repository.getDeckById(userId, id);
  }
}