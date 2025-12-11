class DeckStatistics {
  final int totalCards;
  final int dueCards;
  final int learnedCards;
  final double avgInterval;
  final double retentionRate;
  final int todayReviews;
  final int totalReviews;
  final Map<String, int> intervalBuckets;

  DeckStatistics({
    required this.totalCards,
    required this.dueCards,
    required this.learnedCards,
    required this.avgInterval,
    required this.retentionRate,
    required this.todayReviews,
    required this.totalReviews,
    required this.intervalBuckets,
  });
}