import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/data/datasources/local/database/dao/flashcard_dao.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/flashcard_mapper.dart';

class FlashcardsLocalSource {
  final AppDatabase _database;
  final FlashcardDao _flashcardDao;

  FlashcardsLocalSource() :
        _database = AppDatabase(),
        _flashcardDao = FlashcardDao(AppDatabase());

  Future<void> saveFlashcard(FlashcardModel flashcard) async {
    await _flashcardDao.saveFlashcard(flashcard.toLocalDto());
  }

  Future<void> removeFlashcard(String id) async {
    await _flashcardDao.removeFlashcard(id);
  }

  Future<FlashcardModel> getFlashcard(String id) async {
    final flashcardDto = await _flashcardDao.getFlashcard(id);
    if (flashcardDto == null) throw Exception('Flashcard not found');
    return flashcardDto.toModel();
  }

  Future<List<FlashcardModel>> getFlashcardsByDeckId(String deckId) async {
    final flashcardDtos = await _flashcardDao.getFlashcardsByDeckId(deckId);
    return flashcardDtos.map((dto) => dto.toModel()).toList();
  }

  Future<void> removeFlashcardsByDeckId(String deckId) async {
    await _flashcardDao.removeFlashcardsByDeckId(deckId);
  }

  Stream<List<FlashcardModel>> watchFlashcardsByDeckId(String deckId) {
    return _flashcardDao.watchFlashcardsByDeckId(deckId).map((flashcards) => flashcards.map((dto) => dto.toModel()).toList());
  }

  Future<List<FlashcardModel>> getDueFlashcards() async {
    final now = DateTime.now();
    final flashcardsDto = await _flashcardDao.getDueFlashcards(now);
    return flashcardsDto.map((dto) => dto.toModel()).toList();
  }

  void close() async {
    await _database.close();
  }
}