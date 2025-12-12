import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class RemoveDeckUseCase {
  final FlashcardRepository repository;

  RemoveDeckUseCase(this.repository);

  Future<void> execute(int userId, String id) async {
    await repository.removeDeck(userId, id);
  }
}