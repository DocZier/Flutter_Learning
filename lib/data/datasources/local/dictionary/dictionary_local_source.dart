
import '../../../../core/models/dictionary/dictionary_entity.dart';

class DictionaryLocalDataSource {

  static final List<Map<String, dynamic>> _history = [];
  static final List<Map<String, dynamic>> _savedWords = [];

  List<String> getHistory() {
    return _history.map((e) => e['query'] as String).toList();
  }

  void saveHistory(String query) {
    if (_history.length >= 5) {
      _history.removeAt(0);
    }
    _history.add({
      'query': query,
    });
  }

  void clearHistory() {
    _history.clear();
  }

  List<DictionaryWordEntity> getWords() {
    return _savedWords.map(_mapToEntity).toList();
  }

  DictionaryWordEntity getWordById(int id) {
    return _mapToEntity(_savedWords.firstWhere((word) => word['id'] == id.toString()));
  }

  void saveWord(DictionaryWordEntity word) {
    _savedWords.add({
      'id': word.id,
      'word': word.word,
      'furigana': word.furigana,
      'romanji': word.romanji,
      'meaning': word.meaning,
      'examples': word.examples,
    });
  }

  void deleteWord(int id) {
    _savedWords.removeWhere((word) => word['id'] == id.toString());
  }

  void clear() {
    _savedWords.clear();
  }

  DictionaryWordEntity _mapToEntity(Map<String, dynamic> map) {
    return DictionaryWordEntity(
      id: int.parse(map['id']),
      word: map['word'],
      furigana: map['furigana'],
      romanji: map['romanji'],
      meaning: map['meaning'],
      examples: List<String>.from(map['examples']),
    );
  }
}