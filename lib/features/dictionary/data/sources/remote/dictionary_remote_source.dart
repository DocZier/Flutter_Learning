import '../../../domain/entities/dictionary_entity.dart';

class DictionaryRemoteDataSource {
  static final List<Map<String, dynamic>> _words = [
    {
      'id': '1',
      'word': '食べる',
      'furigana': 'たべる',
      'romanji': 'taberu',
      'meaning': 'есть, кушать',
      'examples': ['ご飯を食べる', 'パンを食べる', '早く食べて'],
    },
    {
      'id': '2',
      'word': '行く',
      'furigana': 'いく',
      'romanji': 'iku',
      'meaning': 'идти, уходить',
      'examples': ['学校に行く', '東京へ行く', '早く行って'],
    },
    {
      'id': '3',
      'word': '見る',
      'furigana': 'みる',
      'romanji': 'miru',
      'meaning': 'смотреть, видеть',
      'examples': ['映画を見る', '空を見る', 'よく見て'],
    },
    {
      'id': '4',
      'word': '猫',
      'furigana': 'ねこ',
      'romanji': 'neko',
      'meaning': 'кошка',
      'examples': ['猫が好き', '黒い猫', '猫を飼っている'],
    },
    {
      'id': '5',
      'word': '大きい',
      'furigana': 'おおきい',
      'romanji': 'ookii',
      'meaning': 'большой',
      'examples': ['大きい家', '大きい犬', '声が大きい'],
    },
  ];

  Future<List<DictionaryWordEntity>> getWords() async {
    return _words.map(_mapToEntity).toList();
  }

  Future<DictionaryWordEntity> getWordById(int id) async {
    return _mapToEntity(_words.firstWhere((word) => word['id'] == id.toString()));
  }

  Future<List<DictionaryWordEntity>> search(String query) async {
    final lower = query.toLowerCase();

    return _words.where((word) {
      return word['word'].toString().contains(query) ||
          word['furigana'].toString().contains(query) ||
          word['romanji'].toString().toLowerCase().contains(lower) ||
          word['meaning'].toString().toLowerCase().contains(lower);
    }).map(_mapToEntity).toList();
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