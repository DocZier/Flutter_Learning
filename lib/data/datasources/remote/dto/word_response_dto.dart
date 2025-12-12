import 'package:json_annotation/json_annotation.dart';
import 'package:test_practic/data/datasources/remote/dto/single_word_response_dto.dart';
import 'dictionary_word_dto.dart';

part 'word_response_dto.g.dart';

@JsonSerializable()
class WordResponseDto {
  final int total;
  final int offset;
  final int limit;
  final List<SingleWordResponseDto> words;

  WordResponseDto({
    required this.total,
    required this.offset,
    required this.limit,
    required this.words,
  });

  factory WordResponseDto.fromJson(Map<String, dynamic> json) => _$WordResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WordResponseDtoToJson(this);
}