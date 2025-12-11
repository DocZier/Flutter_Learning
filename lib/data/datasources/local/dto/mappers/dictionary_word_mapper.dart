import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/local/dto/dictionary_word_dto.dart';

extension SavedWordMapper on DictionarySavedWordDto {
  DictionaryWordModel toModel() {
    return DictionaryWordModel(
      id: int.tryParse(id) ?? 0,
      word: word,
      furigana: furigana,
      romanji: romanji,
      meaning: meaning,
      examples: examples,
    );
  }
}

extension DictionaryWordModelToSavedDto on DictionaryWordModel {
  DictionarySavedWordDto toSavedWordDto() {
    return DictionarySavedWordDto(
      id: id.toString(),
      word: word,
      furigana: furigana,
      romanji: romanji,
      meaning: meaning,
      examples: examples,
      savedAt: DateTime.now(),
    );
  }
}