import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/local/dto/dictionary_history_dto.dart';
import 'package:test_practic/data/datasources/local/dto/dictionary_word_dto.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/dictionary_history_mapper.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/dictionary_word_mapper.dart';


class DictionaryLocalDataSource {
  static final List<DictionaryHistoryItemDto> _history = [];
  static final List<DictionarySavedWordDto> _savedWords = [];

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

  List<DictionaryWordModel> getWords() {
    return _savedWords.map((dto) => dto.toModel()).toList();
  }

  DictionaryWordModel getWordById(int id) {
    final dto = _savedWords.firstWhere((word) => word.id == id.toString());
    return dto.toModel();
  }

  void saveWord(DictionaryWordModel word) {
    final existingIndex = _savedWords.indexWhere((saved) => saved.id == word.id.toString());
    if (existingIndex != -1) {
      _savedWords[existingIndex] = word.toSavedWordDto();
    } else {
      _savedWords.add(word.toSavedWordDto());
    }
  }

  void deleteWord(int id) {
    _savedWords.removeWhere((word) => word.id == id.toString());
  }

  void clear() {
    _savedWords.clear();
  }
}