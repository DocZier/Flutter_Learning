import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/deck_local_source.dart';
import 'package:test_practic/data/datasources/local/flashcards_local_source.dart';
import 'package:test_practic/data/datasources/remote/deck_remote_source.dart';
import 'package:test_practic/data/datasources/remote/flashcards_remote_source.dart';

abstract class FlashcardRepository {
  Future<List<FlashcardModel>> getFlashcardsByDeckId(String deckId);
  Future<void> saveFlashcard(FlashcardModel flashcard);
  Future<void> removeFlashcard(String deckId, String id);
  Future<void> removeFlashcardsByDeckId(String deckId);
  Future<List<DeckModel>> getUsersDecks(int userId);
  Future<void> saveDeck(DeckModel deck);
  Future<void> removeDeck(int userId, String id);
  Future<void> removeDecksByUserId(int userId);
  Future<DeckModel> getDeckById(int userId, String id);
  FlashcardModel applyQuality(FlashcardModel entity, int quality);
}