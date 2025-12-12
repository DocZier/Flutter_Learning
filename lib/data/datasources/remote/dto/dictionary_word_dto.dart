class DictionaryWordDto {
  final String id;
  final String word;
  final String furigana;
  final String romaji;
  final String meaning;
  final List<String> examples;

  DictionaryWordDto({
    required this.id,
    required this.word,
    required this.furigana,
    required this.romaji,
    required this.meaning,
    this.examples = const [],
  });

  factory DictionaryWordDto.fromJson(Map<String, dynamic> json) {
    return DictionaryWordDto(
      id: json['id']?.toString() ?? '0',
      word: json['word'] ?? '',
      furigana: json['furigana'] ?? '',
      romaji: json['romaji'] ?? '',
      meaning: json['meaning'] ?? '',
      examples: List<String>.from(json['examples'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'furigana': furigana,
      'romaji': romaji,
      'meaning': meaning,
      'examples': examples,
    };
  }
}