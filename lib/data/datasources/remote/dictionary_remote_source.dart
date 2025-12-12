import 'package:dio/dio.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/dio_client.dart';
import 'package:test_practic/data/datasources/remote/api/dictionary_api.dart';
import 'package:test_practic/data/datasources/remote/dto/dictionary_word_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/dictionary_word_mapper.dart';


class DictionaryRemoteDataSource {
  final DictionaryApi _dictionaryApi;

  DictionaryRemoteDataSource(this._dictionaryApi);

  Future<List<DictionaryWordModel>> getWords() async {
    try {
      final response = await _dictionaryApi.getAllWords();
      return response.toModelList();
    } catch (e) {
      throw Exception('Failed to fetch words: $e');
    }
  }

  Future<DictionaryWordModel> getWordByWord(String query) async {
    try {
      final response = await _dictionaryApi.searchWord(query);
      if (response.words.isEmpty) {
        throw Exception('Word not found: $query');
      }
      return response.words.first.toModel();
    } catch (e) {
      throw Exception('Failed to fetch word: $e');
    }
  }

  Future<List<DictionaryWordModel>> search(String query) async {
    try {
      final isRandomSearch = query.trim().isEmpty;
      if (isRandomSearch) {
        final randomWords = <DictionaryWordModel>[];
        for (var i = 0; i < 5; i++) {
          try {
            final response = await _dictionaryApi.getRandomWord();
            randomWords.add(response.toModel());
          } catch (e) {
            continue;
          }
          if (randomWords.length >= 5) break;
        }
        return randomWords;
      }

      final response = await _dictionaryApi.searchWord(query);
      return response.toModelList();
    } catch (e) {
      throw Exception('Failed to search words: $e');
    }
  }
}