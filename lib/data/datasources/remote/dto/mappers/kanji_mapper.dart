
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/data/datasources/remote/dto/kanji_dto.dart';

extension KanjiDetailMapper on KanjiDetailDto {
  KanjiDetailModel toModel() {
    final kunyomi = kunReadings.map((reading) => KunyomiReading(
      reading: reading,
      meanings: meanings,
    )).toList();

    final onyomi = onReadings.map((reading) => OnyomiReading(
      reading: reading,
    )).toList();

    return KanjiDetailModel(
      kanji: kanji,
      meanings: meanings,
      kunyomi: kunyomi,
      onyomi: onyomi,
      grade: grade,
      jlptLevel: jlpt.isNotEmpty ? 'N$jlpt' : 'N/A',
      strokes: List.generate(strokeCount, (index) => 'STROKE').toList(),
    );
  }
}

extension KanjiWordExampleMapper on KanjiWordExampleDto {
  KanjiWordExampleModel toModel() {
    String word = '';
    String reading = '';
    List<String> meaningsList = [];

    if (variants.isNotEmpty) {
      final variant = variants.first as Map<String, dynamic>;
      word = variant['written']?.toString() ?? '';
      reading = variant['pronounced']?.toString() ?? '';
    }

    if (meanings.isNotEmpty) {
      final meaning = meanings.first as Map<String, dynamic>;
      final glosses = meaning['glosses'] as List?;
      if (glosses != null) {
        meaningsList = glosses.map((g) => g.toString()).toList();
      }
    }

    return KanjiWordExampleModel(
      word: word,
      reading: reading,
      meanings: meaningsList,
    );
  }
}