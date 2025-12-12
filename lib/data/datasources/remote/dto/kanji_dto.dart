class KanjiDetailDto {
  final String kanji;
  final List<String> meanings;
  final List<String> kunReadings;
  final List<String> onReadings;
  final int grade;
  final String jlpt;
  final int strokeCount;

  KanjiDetailDto({
    required this.kanji,
    required this.meanings,
    required this.kunReadings,
    required this.onReadings,
    required this.grade,
    required this.jlpt,
    required this.strokeCount,
  });

  factory KanjiDetailDto.fromJson(Map<String, dynamic> json) {
    return KanjiDetailDto(
      kanji: json['kanji'] ?? '',
      meanings: List<String>.from(json['meanings'] ?? []),
      kunReadings: List<String>.from(json['kun_readings'] ?? []),
      onReadings: List<String>.from(json['on_readings'] ?? []),
      grade: json['grade'] ?? 0,
      jlpt: json['jlpt']?.toString() ?? '',
      strokeCount: json['stroke_count'] ?? 0,
    );
  }
}

class KanjiWordExampleDto {
  final List<dynamic> meanings;
  final List<dynamic> variants;

  KanjiWordExampleDto({
    required this.meanings,
    required this.variants,
  });

  factory KanjiWordExampleDto.fromJson(Map<String, dynamic> json) {
    return KanjiWordExampleDto(
      meanings: List<dynamic>.from(json['meanings'] ?? []),
      variants: List<dynamic>.from(json['variants'] ?? []),
    );
  }
}