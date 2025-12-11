import '../../domain/entities/deck_entity.dart';
import '../../domain/entities/flashcard_entity.dart';
import '../source/local/deck_local_source.dart';
import '../source/local/flashcards_local_source.dart';
import '../source/remote/deck_remote_source.dart';
import '../source/remote/flashcards_remote_source.dart';

abstract class FlashcardRepository {
    List<FlashcardEntity> getFlashcardsByDeckId(String deckId);
    Future<void> saveFlashcard(FlashcardEntity flashcard);
    Future<void> removeFlashcard(String deckId, String id);
    Future<void> removeFlashcardsByDeckId(String deckId);
    List<DeckEntity> getUsersDecks(int userId);
    Future<void> saveDeck(DeckEntity deck);
    Future<void> removeDeck(int userId, String id);
    Future<void> removeDecksByUserId(int userId);
    DeckEntity getDeckById(int userId, String id);
    FlashcardEntity applyQuality(FlashcardEntity entity ,int quality);
}

class FlashcardRepositoryImpl extends FlashcardRepository {
    final FlashcardsRemoteSource _remoteFlashcardSource;
    final DeckRemoteSource _remoteDeckSource;
    final FlashcardsLocalSource _localFlashcardSource;
    final DeckLocalSource _localDeckSource;

    FlashcardRepositoryImpl({
      required FlashcardsRemoteSource remoteFlashcardSource,
      required DeckRemoteSource remoteDeckSource,
      required FlashcardsLocalSource localFlashcardSource,
      required DeckLocalSource localDeckSource,

    }) :  _remoteFlashcardSource = remoteFlashcardSource,
          _remoteDeckSource = remoteDeckSource,
          _localFlashcardSource = localFlashcardSource,
          _localDeckSource = localDeckSource;

    @override
    List<FlashcardEntity> getFlashcardsByDeckId(String deckId) {
      return _localFlashcardSource.getFlashcardsByDeckId(deckId);
    }

    @override
    Future<void> saveFlashcard(FlashcardEntity flashcard) async {
      _localFlashcardSource.saveFlashcard(flashcard);
      return await _remoteFlashcardSource.saveFlashcard(flashcard);
    }

    @override
    Future<void> removeFlashcard(String deckId, String id) async {
      _localFlashcardSource.removeFlashcard(id);
      return await _remoteFlashcardSource.removeFlashcard(deckId, id);
    }

    @override
    Future<void> removeFlashcardsByDeckId(String deckId) async {
      _localFlashcardSource.removeFlashcardsByDeckId(deckId);
      return await _remoteFlashcardSource.removeFlashcardsByDeckId(deckId);
    }

    @override
    List<DeckEntity> getUsersDecks(int userId) {
      return _localDeckSource.getUsersDecks(userId);
    }

    @override
    DeckEntity getDeckById(int userId, String id) {
      return _localDeckSource.getDeck(userId, id);
    }

    @override
    Future<void> saveDeck(DeckEntity deck) async {
      _localDeckSource.saveDeck(deck);
      return await _remoteDeckSource.saveDeck(deck);
    }

    @override
    Future<void> removeDeck(int userId, String id) async {
      _localDeckSource.removeDeck(id);
      return await _remoteDeckSource.removeDeck(userId, id);
    }

    @override
    Future<void> removeDecksByUserId(int userId) async {
      _localDeckSource.removeDecksByUserId(userId);
      return await _remoteDeckSource.removeDecksByUserId(userId);
    }

    @override
    FlashcardEntity applyQuality(FlashcardEntity entity ,int quality) {
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