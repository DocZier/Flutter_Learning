class KanjiDetailModel {
  final String kanji;
  final List<String> meanings;
  final List<KunyomiReading> kunyomi;
  final List<OnyomiReading> onyomi;
  final int grade;
  final String jlptLevel;
  final List<String> strokes;

  KanjiDetailModel({
    required this.kanji,
    required this.meanings,
    required this.kunyomi,
    required this.onyomi,
    required this.grade,
    required this.jlptLevel,
    required this.strokes,
  });

  KanjiDetailModel copyWith({
    String? kanji,
    List<String>? meanings,
    List<KunyomiReading>? kunyomi,
    List<OnyomiReading>? onyomi,
    int? grade,
    String? jlptLevel,
    List<String>? strokes,
  }) {
    return KanjiDetailModel(
      kanji: kanji ?? this.kanji,
      meanings: meanings ?? this.meanings,
      kunyomi: kunyomi ?? this.kunyomi,
      onyomi: onyomi ?? this.onyomi,
      grade: grade ?? this.grade,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      strokes: strokes ?? this.strokes,
    );
  }
}

class KunyomiReading {
  final String reading;
  final List<String> meanings;

  KunyomiReading({
    required this.reading,
    required this.meanings,
  });
}

class OnyomiReading {
  final String reading;

  OnyomiReading({
    required this.reading,
  });
}

class KanjiReadingModel {
  final String kanji;
  final String reading;

  KanjiReadingModel({
    required this.kanji,
    required this.reading,
  });
}

class KanjiWordExampleModel {
  final String word;
  final String reading;
  final List<String> meanings;

  KanjiWordExampleModel({
    required this.word,
    required this.reading,
    required this.meanings,
  });
}