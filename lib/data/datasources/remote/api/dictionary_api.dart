import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:test_practic/data/datasources/remote/dto/single_word_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/word_response_dto.dart';

part 'dictionary_api.g.dart';

@RestApi()
abstract class DictionaryApi {
  factory DictionaryApi(Dio dio, {String baseUrl}) = _DictionaryApi;

  @GET('/api/words/all')
  Future<WordResponseDto> getAllWords();

  @GET('/api/words')
  Future<WordResponseDto> searchWord(@Query('word') String query);

  @GET('/api/words/random')
  Future<SingleWordResponseDto> getRandomWord();
}