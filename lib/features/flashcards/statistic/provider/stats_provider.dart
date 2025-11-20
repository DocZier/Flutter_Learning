import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/statistic.dart';
import '../../../../provider/app_data_provider.dart';

part 'stats_provider.g.dart';

@riverpod
DeckStatistics deckStatistics(Ref ref, {required String deckId}) {
  final deck = ref.read(appDataProvider.notifier).getDeckById(deckId);
  final cards = deck.flashcards;

  final now = DateTime.now();
  final total = cards.length;

  final due = cards.where((c) => c.nextReview.isBefore(now)).length;
  final learned = total - due;
  final avgInterval =
      cards.map((e) => e.interval).reduce((a, b) => a + b) / total;
  final retention = learned / total * 100;
  final today = cards.where((c) => c.nextReview.day == now.day).length;
  final totalReviews = cards.where((c) => c.interval > 0).length;

  final buckets = {'0-1 дней': 0, '2-7 дней': 0, '8-30 дней': 0, '31+ дней': 0};

  for (var c in cards) {
    if (c.interval <= 1) {
      buckets['0-1 дней'] = buckets['0-1 дней']! + 1;
    } else if (c.interval <= 7) {
      buckets['2-7 дней'] = buckets['2-7 дней']! + 1;
    } else if (c.interval <= 30) {
      buckets['8-30 дней'] = buckets['8-30 дней']! + 1;
    } else {
      buckets['31+ дней'] = buckets['31+ дней']! + 1;
    }
  }

  return DeckStatistics(
    totalCards: total,
    dueCards: due,
    learnedCards: learned,
    avgInterval: avgInterval,
    retentionRate: retention,
    todayReviews: today,
    totalReviews: totalReviews,
    intervalBuckets: buckets,
  );
}
