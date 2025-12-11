class DictionaryWordDto {
  final String id;
  final String word;
  final String furigana;
  final String romanji;
  final String meaning;
  final List<String> examples;

  DictionaryWordDto({
    required this.id,
    required this.word,
    required this.furigana,
    required this.romanji,
    required this.meaning,
    required this.examples,
  });

  factory DictionaryWordDto.fromJson(Map<String, dynamic> json) {
    return DictionaryWordDto(
      id: json['id'].toString(),
      word: json['word'],
      furigana: json['furigana'],
      romanji: json['romanji'],
      meaning: json['meaning'],
      examples: List<String>.from(json['examples'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'furigana': furigana,
      'romanji': romanji,
      'meaning': meaning,
      'examples': examples,
    };
  }
}