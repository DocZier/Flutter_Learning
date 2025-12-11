import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';

class GetUsersDecksUseCase {
  final FlashcardRepository repository;

  GetUsersDecksUseCase(this.repository);

  List<DeckModel> execute(int userId) {
    return repository.getUsersDecks(userId);
  }
}