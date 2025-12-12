import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/local/database/dao/dictionary_dao.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';
import 'package:test_practic/data/datasources/local/dto/dictionary_history_dto.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/dictionary_history_mapper.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/dictionary_word_mapper.dart';

class DictionaryLocalDataSource {
  static final List<DictionaryHistoryItemDto> _history = [];
  final AppDatabase _database;
  final DictionaryDao _dictionaryDao;

  DictionaryLocalDataSource()
      : _database = AppDatabase(),
        _dictionaryDao = DictionaryDao(AppDatabase());

  List<String> getHistory() {
    return _history.map((item) => item.toQuery()).toList();
  }

  void saveHistory(String query) {
    if (_history.length >= 5) {
      _history.removeAt(0);
    }
    _history.add(query.toHistoryItemDto());
  }

  void clearHistory() {
    _history.clear();
  }

  Stream<List<DictionaryWordModel>> watchSavedWords() {
    return _dictionaryDao.watchSavedWords().map(
          (words) => words.map((dto) => dto.toModel()).toList(),
    );
  }

  Future<List<DictionaryWordModel>> getWords() async {
    final wordDtos = await _dictionaryDao.getSavedWords();
    return wordDtos.map((dto) => dto.toModel()).toList();
  }

  Future<DictionaryWordModel> getWordById(int id) async {
    final wordDto = await _dictionaryDao.getSavedWordById(id.toString());
    if (wordDto == null) {
      throw Exception('Word not found with ID: $id');
    }
    return wordDto.toModel();
  }

  Future<void> saveWord(DictionaryWordModel word) async {
    await _dictionaryDao.saveSavedWord(word.toSavedWordDto());
  }

  Future<void> deleteWord(String word) async {
    await _dictionaryDao.deleteSavedWord(word);
  }

  Future<void> clear() async {
    await _dictionaryDao.clearAllSavedWords();
  }

  void close() async {
    await _database.close();
  }
}