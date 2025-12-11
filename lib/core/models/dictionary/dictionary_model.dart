class DictionaryWordModel {
  final int id;
  final String word;
  final String furigana;
  final String romanji;
  final String meaning;
  final List<String> examples;

  const DictionaryWordModel({
    required this.id,
    required this.word,
    required this.furigana,
    required this.romanji,
    required this.meaning,
    required this.examples,
  });

  DictionaryWordModel copyWith({
    int? id,
    String? word,
    String? furigana,
    String? romanji,
    String? meaning,
    List<String>? examples,
  }) {
    return DictionaryWordModel(
      id: id ?? this.id,
      word: word ?? this.word,
      furigana: furigana ?? this.furigana,
      romanji: romanji ?? this.romanji,
      meaning: meaning ?? this.meaning,
      examples: examples ?? this.examples,
    );
  }
}