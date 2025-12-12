import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/local/database/dao/deck_dao.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';
import 'package:test_practic/data/datasources/local/dto/deck_dto.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/deck_mapper.dart';

class DeckLocalSource {
  final AppDatabase _database;
  final DeckDao _deckDao;

  DeckLocalSource() :
        _database = AppDatabase(),
        _deckDao = DeckDao(AppDatabase());

  Future<void> saveDeck(DeckModel deck) async {
    await _deckDao.saveDeck(deck.toLocalDto());
  }

  Future<void> removeDeck(int userId, String id) async {
    await _deckDao.removeDeck(userId, id);
  }

  Future<void> removeDecksByUserId(int userId) async {
    await _deckDao.removeDecksByUserId(userId);
  }

  Future<DeckModel> getDeck(int userId, String id) async {
    final deckDto = await _deckDao.getDeckById(userId, id);
    if (deckDto == null) throw Exception('Deck not found');
    return deckDto.toModel();
  }

  Future<List<DeckModel>> getUsersDecks(int userId) async {
    final deckDtos = await _deckDao.getUsersDecks(userId);
    return deckDtos.map((dto) => dto.toModel()).toList();
  }

  Stream<List<DeckModel>> watchUsersDecks(int userId) {
    return _deckDao.watchUsersDecks(userId).map((decks) => decks.map((dto) => dto.toModel()).toList());
  }

  void close() {
    _database.close();
  }
}