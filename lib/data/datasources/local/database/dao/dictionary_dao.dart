import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
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

  Future<DictionarySavedWord?> getSavedWordById(String id) async {
    return (select(dictionarySavedWords)
      ..where((t) => t.id.equals(id))
      ..limit(1))
        .getSingleOrNull();
  }

  Future<int> saveSavedWord(DictionarySavedWord word) {
    return into(dictionarySavedWords).insertOnConflictUpdate(word);
  }

  Future<int> deleteSavedWord(String word) async {
    return (delete(dictionarySavedWords)..where((t) => t.word.equals(word))).go();
  }

  Future<void> clearAllSavedWords() async {
    await delete(dictionarySavedWords).go();
  }
}