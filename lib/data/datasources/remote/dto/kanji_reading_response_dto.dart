import 'package:json_annotation/json_annotation.dart';

part 'kanji_reading_response_dto.g.dart';

@JsonSerializable()
class KanjiReadingResponseDto {
  final List<String> main_kanji;
  final List<String> name_kanji;
  final String reading;

  KanjiReadingResponseDto({
    required this.main_kanji,
    required this.name_kanji,
    required this.reading,
  });

  factory KanjiReadingResponseDto.fromJson(Map<String, dynamic> json) => _$KanjiReadingResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiReadingResponseDtoToJson(this);
}