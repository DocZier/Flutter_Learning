import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class GetDeckByIdUseCase {
  final FlashcardRepository repository;

  GetDeckByIdUseCase(this.repository);

  DeckModel execute(int userId, String id) {
    return repository.getDeckById(userId, id);
  }
}