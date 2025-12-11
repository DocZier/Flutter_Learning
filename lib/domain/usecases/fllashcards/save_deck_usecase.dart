import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class SaveDeckUseCase {
  final FlashcardRepository repository;

  SaveDeckUseCase(this.repository);

  Future<void> execute(DeckModel deck) async {
    await repository.saveDeck(deck);
  }
}