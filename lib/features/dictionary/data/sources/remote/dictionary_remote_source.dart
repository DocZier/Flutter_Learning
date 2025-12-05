import '../../../domain/entities/dictionary_entity.dart';

class DictionaryRemoteDataSource {
  static final List<Map<String, dynamic>> _words = [
    {
      'id': '1',
      'word': 'test1',
      'furigana': 'test1',
      'romanji': 'test1',
      'meaning': 'test1',
      'examples': ['test', 'test', 'test'],
    },
    {
      'id': '2',
      'word': 'test2',
      'furigana': 'test2',
      'romanji': 'test2',
      'meaning': 'test2',
      'examples': ['test', 'test', 'test'],
    },
  ];

  Future<List<DictionaryWordEntity>> getWords() async {
    return _words.map(_mapToEntity).toList();
  }

  Future<DictionaryWordEntity> getWordById(int id) async {
    return _mapToEntity(_words.firstWhere((word) => word['id'] == id.toString()));
  }

  Future<List<DictionaryWordEntity>> search(String query) async {
    return _words.where((word) => word['word'].contains(query)).map(_mapToEntity).toList();
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