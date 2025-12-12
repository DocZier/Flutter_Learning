import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_detail_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_reading_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_word_example_response_dto.dart';

part 'kanji_api.g.dart';

@RestApi()
abstract class KanjiApi {
  factory KanjiApi(Dio dio, {String baseUrl}) = _KanjiApi;

  @GET('/kanji/{character}')
  Future<KanjiDetailResponseDto> getKanjiDetails(@Path('character') String character);

  @GET('/reading/{reading}')
  Future<KanjiReadingResponseDto> searchKanjiByReading(@Path('reading') String reading);

  @GET('/words/{kanji}')
  Future<List<KanjiWordExampleResponseDto>> getWordExamples(@Path('kanji') String kanji);
}