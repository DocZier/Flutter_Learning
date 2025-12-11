class DictionaryHistoryItemDto {
  final String query;
  final DateTime timestamp;

  DictionaryHistoryItemDto({
    required this.query,
    required this.timestamp,
  });

  factory DictionaryHistoryItemDto.fromJson(Map<String, dynamic> json) {
    return DictionaryHistoryItemDto(
      query: json['query'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}