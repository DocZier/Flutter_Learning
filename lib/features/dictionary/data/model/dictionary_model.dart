import '../../domain/entities/dictionary_entity.dart';

class DictionaryWord extends DictionaryWordEntity {
  const DictionaryWord({
    required super.id,
    required super.word,
    required super.furigana,
    required super.romanji,
    required super.meaning,
    required super.examples,
  });

  factory DictionaryWord.fromEntity(DictionaryWordEntity entity) {
    return DictionaryWord(
      id: entity.id,
      word: entity.word,
      furigana: entity.furigana,
      romanji: entity.romanji,
      meaning: entity.meaning,
      examples: entity.examples,
    );
  }

  DictionaryWordEntity toEntity() => DictionaryWordEntity(
    id: id,
    word: word,
    furigana: furigana,
    romanji: romanji,
    meaning: meaning,
    examples: examples,
  );

  factory DictionaryWord.fromJson(Map<String, dynamic> json) {
    return DictionaryWord(
      id: json['id'],
      word: json['word'],
      furigana: json['furigana'],
      romanji: json['romanji'],
      meaning: json['meaning'],
      examples: List<String>.from(json['examples']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'word': word,
    'furigana': furigana,
    'romanji': romanji,
    'meaning': meaning,
    'examples': examples,
  };
}
