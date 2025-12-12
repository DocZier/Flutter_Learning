import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_practic/data/datasources/local/database/dao/deck_dao.dart';
import 'package:test_practic/data/datasources/local/database/dao/dictionary_dao.dart';
import 'package:test_practic/data/datasources/local/database/dao/flashcard_dao.dart';
import 'package:test_practic/data/datasources/local/database/tables/deck_table.dart';
import 'package:test_practic/data/datasources/local/database/tables/dictionary_words_table.dart';
import 'package:test_practic/data/datasources/local/database/tables/flashcard_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Decks,
  Flashcards,
  DictionarySavedWords,
 ],
    daos: [
      DeckDao,
      FlashcardDao,
      DictionaryDao
    ])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}