import 'package:json_annotation/json_annotation.dart';

part 'kanji_detail_response_dto.g.dart';

@JsonSerializable()
class KanjiDetailResponseDto {
  final int freq_mainichi_shinbun;
  final int grade;
  final String? heisig_en;
  final dynamic jlpt;
  final String kanji;
  final List<String> kun_readings;
  final List<String> meanings;
  final List<String> name_readings;
  final List<dynamic> notes;
  final List<String> on_readings;
  final int stroke_count;
  final String unicode;

  KanjiDetailResponseDto({
    required this.freq_mainichi_shinbun,
    required this.grade,
    this.heisig_en,
    this.jlpt,
    required this.kanji,
    required this.kun_readings,
    required this.meanings,
    required this.name_readings,
    required this.notes,
    required this.on_readings,
    required this.stroke_count,
    required this.unicode,
  });

  factory KanjiDetailResponseDto.fromJson(Map<String, dynamic> json) => _$KanjiDetailResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$KanjiDetailResponseDtoToJson(this);
}