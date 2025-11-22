import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/model/flashcards_model.dart';
import '../../../data/repositories/flashcard_repository.dart';
import '../../state/statistic/statistic_state.dart';

part 'stats_provider.g.dart';

@riverpod
class Statistic extends _$Statistic {
  late final FlashcardRepository _repo;

  @override
  StatisticsState build({required String deckId}) {
    _repo = GetIt.I<FlashcardRepository>();

    final cards = _loadCards(deckId);
    return _calculateStatistics(cards);
  }

  List<Flashcard> _loadCards(String deckId) {
    return _repo
        .getFlashcardsByDeckId(deckId)
        .map(Flashcard.fromEntity)
        .toList();
  }

  StatisticsState _calculateStatistics(List<Flashcard> cards) {
    final totalCards = cards.length;
    if (totalCards == 0) {
      return StatisticsState(
        totalCards: 0,
        dueCards: 0,
        learnedCards: 0,
        avgInterval: 0,
        retentionRate: 0,
        todayReviews: 0,
        totalReviews: 0,
        intervalBuckets: {},
      );
    }

    final now = DateTime.now();

    final dueCards = cards.where((c) => c.nextReview.isBefore(now)).length;
    final learnedCards = cards.where((c) => c.nextReview.isAfter(now)).length;

    final avgInterval =
        cards.map((c) => c.interval).fold(0, (a, b) => a + b) / totalCards;

    final retentionRate = cards.isEmpty
        ? 0.0
        : (cards.where((c) => c.easeFactor >= 2.5).length / cards.length) * 100;

    final todayReviews = cards
        .where((c) => c.lastReviewedAt.day == now.day)
        .length;

    final totalReviews = cards.fold<int>(0, (sum, c) => sum + (c.reviewCount));

    final intervalBuckets = _buildIntervalBuckets(cards);

    return StatisticsState(
      totalCards: totalCards,
      dueCards: dueCards,
      learnedCards: learnedCards,
      avgInterval: avgInterval,
      retentionRate: retentionRate,
      todayReviews: todayReviews,
      totalReviews: totalReviews,
      intervalBuckets: intervalBuckets,
    );
  }

  Map<String, int> _buildIntervalBuckets(List<Flashcard> cards) {
    final buckets = <String, int>{
      "1 день": 0,
      "2–3 дня": 0,
      "4–7 дней": 0,
      "8–14 дней": 0,
      "15+ дней": 0,
    };

    for (final c in cards) {
      if (c.interval <= 1) {
        buckets["1 день"] = buckets["1 день"]! + 1;
      } else if (c.interval <= 3) {
        buckets["2–3 дня"] = buckets["2–3 дня"]! + 1;
      } else if (c.interval <= 7) {
        buckets["4–7 дней"] = buckets["4–7 дней"]! + 1;
      } else if (c.interval <= 14) {
        buckets["8–14 дней"] = buckets["8–14 дней"]! + 1;
      } else {
        buckets["15+ дней"] = buckets["15+ дней"]! + 1;
      }
    }

    return buckets;
  }
}
