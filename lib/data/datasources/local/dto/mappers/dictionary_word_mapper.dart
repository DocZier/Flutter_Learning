import 'dart:convert';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';

extension SavedWordMapper on DictionarySavedWord {
  DictionaryWordModel toModel() {
    return DictionaryWordModel(
      id: int.tryParse(id) ?? 0,
      word: word,
      furigana: furigana,
      romanji: romanji,
      meaning: meaning,
      examples: List<String>.from(jsonDecode(examples)),
    );
  }
}

extension DictionaryWordModelToSavedDto on DictionaryWordModel {
  DictionarySavedWord toSavedWordDto() {
    return DictionarySavedWord(
      id: id.toString(),
      word: word,
      furigana: furigana,
      romanji: romanji,
      meaning: meaning,
      examples: jsonEncode(examples),
      savedAt: DateTime.now(),
    );
  }
}