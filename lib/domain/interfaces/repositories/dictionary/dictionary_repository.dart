import 'package:test_practic/core/models/dictionary/dictionary_model.dart';

abstract class DictionaryRepository {
  Future<List<DictionaryWordModel>> getWords();
  Future<DictionaryWordModel> getWordById(int id);
  List<DictionaryWordModel> getSavedWords();
  Future<List<DictionaryWordModel>> search(String query);
  void saveWord(int id);
  void deleteWord(int id);
  void clear();
  List<String> getHistory();
  void saveHistory(String query);
  void clearHistory();
}