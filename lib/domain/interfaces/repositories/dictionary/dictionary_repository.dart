import 'package:test_practic/core/models/dictionary/dictionary_model.dart';

abstract class DictionaryRepository {
  Future<List<DictionaryWordModel>> getWords();
  Future<DictionaryWordModel> getWordById(int id);
  Future<List<DictionaryWordModel>> getSavedWords();
  Future<List<DictionaryWordModel>> search(String query);
  Future<void> saveWord(int id);
  Future<void> deleteWord(int id);
  Future<void> clear();
  List<String> getHistory();
  void saveHistory(String query);
  void clearHistory();
}