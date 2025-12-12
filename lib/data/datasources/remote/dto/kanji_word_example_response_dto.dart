import 'package:json_annotation/json_annotation.dart';

part 'kanji_word_example_response_dto.g.dart';

@JsonSerializable()
class KanjiWordExampleResponseDto {
  final List<KanjiMeaningDto> meanings;
  final List<KanjiVariantDto> variants;

  KanjiWordExampleResponseDto({
    required this.meanings,
    required this.variants,
  });

  factory KanjiWordExampleResponseDto.fromJson(Map<String, dynamic> json) => _$KanjiWordExampleResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiWordExampleResponseDtoToJson(this);
}

@JsonSerializable()
class KanjiMeaningDto {
  final List<String> glosses;

  KanjiMeaningDto({
    required this.glosses,
  });

  factory KanjiMeaningDto.fromJson(Map<String, dynamic> json) => _$KanjiMeaningDtoFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiMeaningDtoToJson(this);
}

@JsonSerializable()
class KanjiVariantDto {
  @JsonKey(name: 'priorities')
  final List<dynamic> priorities;
  @JsonKey(name: 'pronounced')
  final String pronounced;
  @JsonKey(name: 'written')
  final String written;

  KanjiVariantDto({
    required this.priorities,
    required this.pronounced,
    required this.written,
  });

  factory KanjiVariantDto.fromJson(Map<String, dynamic> json) => _$KanjiVariantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiVariantDtoToJson(this);
}