import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/remote/dto/dictionary_word_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/dictionary_word_mapper.dart';


class DictionaryRemoteDataSource {
  static final List<DictionaryWordDto> _words = [
    DictionaryWordDto(
      id: '1',
      word: '食べる',
      furigana: 'たべる',
      romanji: 'taberu',
      meaning: 'есть, кушать',
      examples: ['ご飯を食べる', 'パンを食べる', '早く食べて'],
    ),
  DictionaryWordDto(
      id: '2',
      word: '行く',
      furigana: 'いく',
      romanji: 'iku',
      meaning: 'идти, уходить',
      examples: ['学校に行く', '東京へ行く', '早く行って'],
  ),
  DictionaryWordDto(
      id: '3',
      word: '見る',
      furigana: 'みる',
      romanji: 'miru',
      meaning: 'смотреть, видеть',
      examples: ['映画を見る', '空を見る', 'よく見て'],
  ),
  DictionaryWordDto(
      id: '4',
      word: '猫',
      furigana: 'ねこ',
      romanji: 'neko',
      meaning: 'кошка',
      examples: ['猫が好き', '黒い猫', '猫を飼っている'],
  ),
  DictionaryWordDto(
      id: '5',
      word: '大きい',
      furigana: 'おおきい',
      romanji: 'ookii',
      meaning: 'большой',
      examples: ['大きい家', '大きい犬', '声が大きい'],
  ),
  ];

  Future<List<DictionaryWordModel>> getWords() async {
    return _words.map((dto) => dto.toModel()).toList();
  }

  Future<DictionaryWordModel> getWordById(int id) async {
    final dto = _words.firstWhere((word) => word.id == id.toString());
    return dto.toModel();
  }

  Future<List<DictionaryWordModel>> search(String query) async {
    final lower = query.toLowerCase();
    final filteredDtos = _words.where((word) {
      return word.word.contains(query) ||
          word.furigana.contains(query) ||
          word.romanji.toLowerCase().contains(lower) ||
          word.meaning.toLowerCase().contains(lower);
    }).toList();
    return filteredDtos.map((dto) => dto.toModel()).toList();
  }
}