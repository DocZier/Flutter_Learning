import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';

abstract class DictionaryRepository {
  Future<List<DictionaryWordModel>> getWords();
  Future<DictionaryWordModel> getWordByWord(String word);
  Future<List<DictionaryWordModel>> getSavedWords();
  Future<List<DictionaryWordModel>> search(String query);
  Future<void> saveWord(String word);
  Future<void> deleteWord(String word);
  Future<void> clear();
  List<String> getHistory();
  void saveHistory(String query);
  void clearHistory();
  Future<KanjiDetailModel> getKanjiDetails(String kanji);
  Future<List<KanjiReadingModel>> searchKanjiByReading(String reading);
  Future<List<KanjiWordExampleModel>> getWordExamples(String kanji);
  Future<KanjiReadingModel> searchKanjiByCharacter(String character);
}