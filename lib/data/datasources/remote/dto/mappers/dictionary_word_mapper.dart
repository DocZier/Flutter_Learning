import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/remote/dto/dictionary_word_dto.dart';

extension DictionaryWordMapper on DictionaryWordDto {
  DictionaryWordModel toModel() {
    return DictionaryWordModel(
      id: int.tryParse(id) ?? 0,
      word: word,
      furigana: furigana,
      romanji: romaji,
      meaning: meaning,
      examples: examples,
    );
  }
}

extension DictionaryWordModelMapper on DictionaryWordModel {
  DictionaryWordDto toDto() {
    return DictionaryWordDto(
      id: id.toString(),
      word: word,
      furigana: furigana,
      romaji: romanji,
      meaning: meaning,
      examples: examples,
    );
  }
}