import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/dictionary_words_table.dart';

part 'dictionary_dao.g.dart';

@DriftAccessor(tables: [DictionarySavedWords])
class DictionaryDao extends DatabaseAccessor<AppDatabase> with _$DictionaryDaoMixin {
  DictionaryDao(AppDatabase db) : super(db);

  Stream<List<DictionarySavedWord>> watchSavedWords() {
    return select(dictionarySavedWords).watch();
  }

  Future<List<DictionarySavedWord>> getSavedWords() async {
    return select(dictionarySavedWords).get();
  }

  Future<DictionarySavedWord?> getSavedWordById(String id) {
    return (select(dictionarySavedWords)..where((t) => t.id.equals(id))..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveSavedWord(DictionarySavedWord word) {
    return into(dictionarySavedWords).insertOnConflictUpdate(word);
  }

  Future<int> deleteSavedWord(String id) {
    return (delete(dictionarySavedWords)..where((t) => t.id.equals(id))).go();
  }
}