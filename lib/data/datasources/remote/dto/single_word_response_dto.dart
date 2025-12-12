import 'package:json_annotation/json_annotation.dart';
import 'dictionary_word_dto.dart';

part 'single_word_response_dto.g.dart';

@JsonSerializable()
class SingleWordResponseDto {
  final String word;
  final String meaning;
  final String furigana;
  final String romaji;
  final int level;

  SingleWordResponseDto({
    required this.word,
    required this.meaning,
    required this.furigana,
    required this.romaji,
    required this.level,
  });

  factory SingleWordResponseDto.fromJson(Map<String, dynamic> json) => _$SingleWordResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SingleWordResponseDtoToJson(this);

  DictionaryWordDto toWordDto() {
    return DictionaryWordDto(
      id: '0',
      word: word,
      furigana: furigana,
      romaji: romaji,
      meaning: meaning,
      examples: [],
    );
  }
}