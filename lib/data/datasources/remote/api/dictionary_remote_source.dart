import 'package:dio/dio.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/dio_client.dart';
import 'package:test_practic/data/datasources/remote/dto/dictionary_word_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/dictionary_word_mapper.dart';


class DictionaryRemoteDataSource {
  final DioClient _dioClient;

  DictionaryRemoteDataSource(this._dioClient);

  Future<List<DictionaryWordModel>> getWords() async {
    try {
      final response = await _dioClient.dio.get('/api/words/all');
      final data = response.data as Map<String, dynamic>;
      final words = (data['words'] as List)
          .map((json) => DictionaryWordDto.fromJson(json))
          .toList();

      return words.map((dto) => dto.toModel()).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch words: ${e.message}');
    }
  }

  Future<DictionaryWordModel> getWordByWord(String query) async {
    try {
      final response = await _dioClient.dio.get('/api/words',
          queryParameters: {'word': query});
      print('${response.data}');

      final data = response.data as Map<String, dynamic>;
      final wordsData = data['words'] as List;

      if (wordsData.isEmpty) {
        throw Exception('Word not found: $query');
      }

      final wordDto = DictionaryWordDto.fromJson(wordsData.first as Map<String, dynamic>);
      return wordDto.toModel();
    } on DioException catch (e) {
      throw Exception('Failed to fetch word: ${e.message}');
    }
  }

  Future<List<DictionaryWordModel>> search(String query) async {
    try {
      final isRandomSearch = query.trim().isEmpty;

      if (isRandomSearch) {
        final randomWords = <DictionaryWordModel>[];
        for (var i = 0; i < 5; i++) {
          try {
            final response = await _dioClient.dio.get('/api/words/random');
            final word = DictionaryWordDto.fromJson(response.data as Map<String, dynamic>);
            randomWords.add(word.toModel());
          } catch (e) {
            continue;
          }
          if (randomWords.length >= 5) break;
        }
        return randomWords;
      }

      final response = await _dioClient.dio.get(
        '/api/words',
        queryParameters: {'word': query},
      );

      final data = response.data as Map<String, dynamic>;
      final wordsData = (data['words'] as List?) ?? [];

      final words = wordsData
          .map((json) => DictionaryWordDto.fromJson(json as Map<String, dynamic>))
          .toList();

      return words.map((dto) => dto.toModel()).toList();
    } on DioException catch (e) {
      throw Exception('Failed to search words: ${e.message}');
    }
  }
}