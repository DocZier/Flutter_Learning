
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_detail_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_reading_response_dto.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_word_example_response_dto.dart';


extension KanjiDetailResponseMapper on KanjiDetailResponseDto {
  KanjiDetailModel toModel() {
    final kunyomi = kun_readings.map((reading) => KunyomiReading(
      reading: reading,
      meanings: meanings,
    )).toList();

    final onyomi = on_readings.map((reading) => OnyomiReading(
      reading: reading,
    )).toList();

    return KanjiDetailModel(
      kanji: kanji,
      meanings: meanings,
      kunyomi: kunyomi,
      onyomi: onyomi,
      grade: grade,
      jlptLevel: jlpt != null && jlpt is String ? 'N$jlpt' : (jlpt != null && jlpt is int ? 'N$jlpt' : 'N/A'),
      strokes: List.generate(stroke_count, (index) => 'STROKE').toList(),
    );
  }
}

extension KanjiReadingResponseMapper on KanjiReadingResponseDto {
  List<KanjiReadingModel> toModelList() {
    final allKanji = [...main_kanji, ...name_kanji].toSet().toList();
    return allKanji.map((kanji) => KanjiReadingModel(
      kanji: kanji,
      reading: reading,
    )).toList();
  }
}

extension KanjiWordExampleResponseMapper on List<KanjiWordExampleResponseDto> {
  List<KanjiWordExampleModel> toModelList() {
    return map((example) => example.toModel()).toList();
  }
}

extension KanjiWordExampleSingleMapper on KanjiWordExampleResponseDto {
  KanjiWordExampleModel toModel() {
    String word = '';
    String reading = '';
    List<String> meaningsList = [];

    if (variants.isNotEmpty) {
      final variant = variants.first;
      word = variant.written;
      reading = variant.pronounced;
    }

    if (meanings.isNotEmpty && meanings.first.glosses.isNotEmpty) {
      meaningsList = meanings.first.glosses;
    }

    return KanjiWordExampleModel(
      word: word,
      reading: reading,
      meanings: meaningsList,
    );
  }
}