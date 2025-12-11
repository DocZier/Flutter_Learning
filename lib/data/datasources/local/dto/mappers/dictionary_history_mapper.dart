import 'package:test_practic/data/datasources/local/dto/dictionary_history_dto.dart';

extension HistoryItemMapper on DictionaryHistoryItemDto {
  String toQuery() {
    return query;
  }
}

extension QueryMapper on String {
  DictionaryHistoryItemDto toHistoryItemDto() {
    return DictionaryHistoryItemDto(
      query: this,
      timestamp: DateTime.now(),
    );
  }
}