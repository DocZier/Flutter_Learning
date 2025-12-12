import 'package:dio/dio.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/dio_client.dart';
import 'package:test_practic/data/datasources/remote/api/kanji_api.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/kanji_mapper.dart';


class KanjiRemoteDataSource {
  final KanjiApi _kanjiApi;

  KanjiRemoteDataSource(this._kanjiApi);

  Future<KanjiDetailModel> getKanjiDetails(String kanji) async {
    try {
      final response = await _kanjiApi.getKanjiDetails(kanji);
      return response.toModel();
    } catch (e) {
      throw Exception('Failed to fetch kanji details: $e');
    }
  }

  Future<List<KanjiReadingModel>> searchKanjiByReading(String reading) async {
    try {
      final response = await _kanjiApi.searchKanjiByReading(reading);
      return response.toModelList();
    } catch (e) {
      if (e.toString().contains('404') || e.toString().contains('400')) {
        return [];
      }
      throw Exception('Failed to search kanji by reading: $e');
    }
  }

  Future<List<KanjiWordExampleModel>> getWordExamples(String kanji) async {
    try {
      final response = await _kanjiApi.getWordExamples(kanji);
      return response.toModelList();
    } catch (e) {
      throw Exception('Failed to fetch word examples: $e');
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
    } catch (e) {
      throw Exception('Failed to search kanji by character: $e');
    }
  }
}