import 'package:dio/dio.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/dio_client.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/kanji_mapper.dart';

class KanjiRemoteDataSource {
  final DioClient _dioClient;

  KanjiRemoteDataSource(this._dioClient);

  Future<KanjiDetailModel> getKanjiDetails(String kanji) async {
    try {
      final response = await _dioClient.kanjiDio.get('kanji/$kanji');
      final kanjiDto = KanjiDetailDto.fromJson(response.data);
      return kanjiDto.toModel();
    } on DioException catch (e) {
      throw Exception('Failed to fetch kanji details: ${e.message}');
    }
  }

  Future<List<KanjiReadingModel>> searchKanjiByReading(String reading) async {
    try {
      final response = await _dioClient.kanjiDio.get('reading/$reading');
      final data = response.data as Map<String, dynamic>;

      final mainKanji = (data['main_kanji'] as List?) ?? [];
      final nameKanji = (data['name_kanji'] as List?) ?? [];

      final allKanji = [...mainKanji, ...nameKanji].toSet().toList();

      return allKanji.map((kanji) => KanjiReadingModel(
        kanji: kanji.toString(),
        reading: reading,
      )).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        return [];
      }
      throw Exception('Failed to search kanji by reading: ${e.message}');
    }
  }

  Future<List<KanjiWordExampleModel>> getWordExamples(String kanji) async {
    try {
      final response = await _dioClient.kanjiDio.get('words/$kanji');
      final data = response.data as List;

      final examples = data
          .map((json) => KanjiWordExampleDto.fromJson(json))
          .toList();

      return examples.map((dto) => dto.toModel()).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch word examples: ${e.message}');
    }
  }

  Future<KanjiReadingModel> searchKanjiByCharacter(String character) async {
    try {
      final kanjiDetails = await getKanjiDetails(character);

      String reading = '';
      if (kanjiDetails.onyomi.isNotEmpty) {
        reading = kanjiDetails.onyomi[0].reading;
      } else if (kanjiDetails.kunyomi.isNotEmpty) {
        reading = kanjiDetails.kunyomi[0].reading;
      }

      return KanjiReadingModel(
        kanji: character,
        reading: reading,
      );
    } on DioException catch (e) {
      throw Exception('Failed to search kanji by character: ${e.message}');
    }
  }
}