import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/flashcard_table.dart';

part 'flashcard_dao.g.dart';

@DriftAccessor(tables: [Flashcards])
class FlashcardDao extends DatabaseAccessor<AppDatabase> with _$FlashcardDaoMixin {
  FlashcardDao(AppDatabase db) : super(db);
  Stream<List<Flashcard>> watchFlashcardsByDeckId(String deckId) {
    return (select(flashcards)..where((t) => t.deckId.equals(deckId))).watch();
  }

  Future<List<Flashcard>> getFlashcardsByDeckId(String deckId) async {
    return (select(flashcards)..where((t) => t.deckId.equals(deckId))).get();
  }

  Future<Flashcard?> getFlashcard(String id) {
    return (select(flashcards)..where((t) => t.id.equals(id))..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveFlashcard(Flashcard flashcard) {
    return into(flashcards).insertOnConflictUpdate(flashcard);
  }

  Future<int> removeFlashcard(String id) {
    return (delete(flashcards)..where((t) => t.id.equals(id))).go();
  }

  Future<int> removeFlashcardsByDeckId(String deckId) {
    return (delete(flashcards)..where((t) => t.deckId.equals(deckId))).go();
  }

  Future<List<Flashcard>> getDueFlashcards(DateTime now) async {
    return (select(flashcards)..where((t) => t.nextReview.isSmallerOrEqualValue(now))).get();
  }
}