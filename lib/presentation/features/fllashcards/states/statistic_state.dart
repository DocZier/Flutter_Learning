class StatisticsState {
  final int totalCards;
  final int dueCards;
  final int learnedCards;
  final double avgInterval;
  final double retentionRate;
  final int todayReviews;
  final int totalReviews;
  final Map<String, int> intervalBuckets;

  StatisticsState({
    required this.totalCards,
    required this.dueCards,
    required this.learnedCards,
    required this.avgInterval,
    required this.retentionRate,
    required this.todayReviews,
    required this.totalReviews,
    required this.intervalBuckets,
  });

  StatisticsState copyWith({
    int? totalCards,
    int? dueCards,
    int? learnedCards,
    double? avgInterval,
    double? retentionRate,
    int? todayReviews,
    int? totalReviews,
    Map<String, int>? intervalBuckets,
  }) {
    return StatisticsState(
      totalCards: totalCards ?? this.totalCards,
      dueCards: dueCards ?? this.dueCards,
      learnedCards: learnedCards ?? this.learnedCards,
      avgInterval: avgInterval ?? this.avgInterval,
      retentionRate: retentionRate ?? this.retentionRate,
      todayReviews: todayReviews ?? this.todayReviews,
      totalReviews: totalReviews ?? this.totalReviews,
      intervalBuckets: intervalBuckets ?? this.intervalBuckets,
    );
  }
}