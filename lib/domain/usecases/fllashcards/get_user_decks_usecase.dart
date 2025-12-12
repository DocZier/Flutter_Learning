import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class GetUsersDecksUseCase {
  final FlashcardRepository repository;

  GetUsersDecksUseCase(this.repository);

  Future<List<DeckModel>> execute(int userId) async {
    return await repository.getUsersDecks(userId);
  }
}