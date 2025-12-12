import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/deck_table.dart';

part 'deck_dao.g.dart';

@DriftAccessor(tables: [Decks])
class DeckDao extends DatabaseAccessor<AppDatabase> with _$DeckDaoMixin {
  DeckDao(AppDatabase db) : super(db);

  Stream<List<Deck>> watchUsersDecks(int userId) {
    return (select(decks)..where((t) => t.userId.equals(userId))).watch();
  }

  Future<List<Deck>> getUsersDecks(int userId) async {
    return (select(decks)..where((t) => t.userId.equals(userId))).get();
  }

  Future<Deck?> getDeckById(int userId, String id) {
    return (select(decks)
      ..where((t) => t.userId.equals(userId) & t.id.equals(id))
      ..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveDeck(Deck deck) {
    return into(decks).insertOnConflictUpdate(deck);
  }

  Future<int> removeDeck(int userId, String id) {
    return (delete(decks)
      ..where((t) => t.userId.equals(userId) & t.id.equals(id)))
        .go();
  }

  Future<int> removeDecksByUserId(int userId) {
    return (delete(decks)..where((t) => t.userId.equals(userId))).go();
  }
}