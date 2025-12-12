import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/remote/dto/dictionary_word_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/single_word_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/word_response_dto.dart';

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

extension WordResponseMapper on WordResponseDto {
  List<DictionaryWordModel> toModelList() {
    return words.map((word) => word.toModel()).toList();
  }
}

extension SingleWordResponseMapper on SingleWordResponseDto {
  DictionaryWordModel toModel() {
    return toWordDto().toModel();
  }
}