import 'package:json_annotation/json_annotation.dart';

part 'dictionary_word_dto.g.dart';

@JsonSerializable()
class DictionaryWordDto {
  final String id;
  final String word;
  final String furigana;
  final String romaji;
  final String meaning;
  final List<String> examples;
  final int? level;

  DictionaryWordDto({
    required this.id,
    required this.word,
    required this.furigana,
    required this.romaji,
    required this.meaning,
    this.examples = const [],
    this.level,
  });

  factory DictionaryWordDto.fromJson(Map<String, dynamic> json) => _$DictionaryWordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DictionaryWordDtoToJson(this);
}