import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import '../../../../core/models/fllashcards/flashcards_model.dart';
import '../states/statistic_state.dart';

part 'stats_provider.g.dart';

@riverpod
class Statistic extends _$Statistic {
  late final GetFlashcardsByDeckIdUseCase _getFlashcardsByDeckIdUseCase;

  @override
  Future<StatisticsState> build({required String deckId}) async {
    _getFlashcardsByDeckIdUseCase = GetIt.I<GetFlashcardsByDeckIdUseCase>();
    final cards = await _loadCards(deckId);
    return _calculateStatistics(cards);
  }

  Future<List<FlashcardModel>> _loadCards(String deckId) async {
    return await _getFlashcardsByDeckIdUseCase.execute(deckId);
  }

  StatisticsState _calculateStatistics(List<FlashcardModel> cards) {
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
    final avgInterval = cards.map((c) => c.interval).fold(0, (a, b) => a + b) / totalCards;
    final retentionRate = cards.isEmpty
        ? 0.0
        : (cards.where((c) => c.easeFactor >= 2.5).length / cards.length) * 100;
    final todayReviews = cards.where((c) => c.lastReviewedAt.day == now.day).length;
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

  Map<String, int> _buildIntervalBuckets(List<FlashcardModel> cards) {
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
