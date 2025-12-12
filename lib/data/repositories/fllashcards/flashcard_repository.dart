import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/deck_local_source.dart';
import 'package:test_practic/data/datasources/local/flashcards_local_source.dart';
import 'package:test_practic/data/datasources/remote/deck_remote_source.dart';
import 'package:test_practic/data/datasources/remote/flashcards_remote_source.dart';
import 'package:test_practic/domain/interfaces/repositories/fllashcards/flashcard_repository.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardsRemoteSource _remoteFlashcardSource;
  final DeckRemoteSource _remoteDeckSource;
  final FlashcardsLocalSource _localFlashcardSource;
  final DeckLocalSource _localDeckSource;

  FlashcardRepositoryImpl({
    required FlashcardsRemoteSource remoteFlashcardSource,
    required DeckRemoteSource remoteDeckSource,
    required FlashcardsLocalSource localFlashcardSource,
    required DeckLocalSource localDeckSource,
  }) : _remoteFlashcardSource = remoteFlashcardSource,
       _remoteDeckSource = remoteDeckSource,
       _localFlashcardSource = localFlashcardSource,
       _localDeckSource = localDeckSource;

  @override
  Future<List<FlashcardModel>> getFlashcardsByDeckId(String deckId) async {
    return await _localFlashcardSource.getFlashcardsByDeckId(deckId);
  }

  @override
  Future<void> saveFlashcard(FlashcardModel flashcard) async {
    await _localFlashcardSource.saveFlashcard(flashcard);
    return await _remoteFlashcardSource.saveFlashcard(flashcard);
  }

  @override
  Future<void> removeFlashcard(String deckId, String id) async {
    await _localFlashcardSource.removeFlashcard(id);
    return await _remoteFlashcardSource.removeFlashcard(deckId, id);
  }

  @override
  Future<void> removeFlashcardsByDeckId(String deckId) async {
    await _localFlashcardSource.removeFlashcardsByDeckId(deckId);
    return await _remoteFlashcardSource.removeFlashcardsByDeckId(deckId);
  }

  @override
  Future<List<DeckModel>> getUsersDecks(int userId) async {
    return await _localDeckSource.getUsersDecks(userId);
  }

  @override
  Future<DeckModel> getDeckById(int userId, String id) async {
    return await _localDeckSource.getDeck(userId, id);
  }

  @override
  Future<void> saveDeck(DeckModel deck) async {
    await _localDeckSource.saveDeck(deck);
    return await _remoteDeckSource.saveDeck(deck);
  }

  @override
  Future<void> removeDeck(int userId, String id) async {
    await _localDeckSource.removeDeck(userId, id);
    return await _remoteDeckSource.removeDeck(userId, id);
  }

  @override
  Future<void> removeDecksByUserId(int userId) async {
    await _localDeckSource.removeDecksByUserId(userId);
    return await _remoteDeckSource.removeDecksByUserId(userId);
  }

  @override
  FlashcardModel applyQuality(FlashcardModel entity, int quality)  {
    int newInterval = entity.interval;
    double newEF = entity.easeFactor;

    if (quality <= 3) {
      newInterval = 1;
    } else {
      newInterval = (newInterval * newEF).round();
    }

    newEF += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (newEF < 1.3) newEF = 1.3;

    final newNextReview = DateTime.now().add(Duration(days: newInterval));

    return entity.copyWith(
      interval: newInterval,
      easeFactor: newEF,
      nextReview: newNextReview,
    );
  }
}
