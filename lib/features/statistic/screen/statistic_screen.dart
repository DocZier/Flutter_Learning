import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/provider/deck_id_provider.dart';
import 'package:test_practic/features/statistic/provider/stats_provider.dart';
import 'package:test_practic/features/statistic/widgets/metric_table.dart';
import 'package:test_practic/features/statistic/widgets/metric_bar_card.dart';
import 'package:test_practic/models/metric.dart';
import 'package:test_practic/state/data_container.dart';
import '../../../models/decks.dart';
import '../../../models/statistic.dart';
import '../../../state/data_repository.dart';

class DeckStatisticsScreen extends ConsumerWidget {
  final String currentDeck;

  const DeckStatisticsScreen({super.key, required this.currentDeck});

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_chart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text('Колода пуста', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildStatisticsContent(BuildContext context, DeckStatistics stats, Deck deck) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressSection(context, stats),
          const SizedBox(height: 24),
          _buildMetricsTable(stats),
          const SizedBox(height: 24),
          _buildReviewActivity(stats),
          const SizedBox(height: 24),
          _buildIntervalDistribution(stats),
        ],
      ),
    );
  }

  Widget _buildIntervalDistribution(DeckStatistics stats) {
    return MetricBarCard(
      title: 'Интервалы',
      metrics: [
        ...stats.intervalBuckets.entries.map((interval) {
          return Metric(
            title: interval.key,
            value: interval.value,
            max: stats.totalCards,
          );
        }),
      ],
    );
  }

  Widget _buildReviewActivity(DeckStatistics stats) {
    return MetricBarCard(
      title: 'Активность просмотра',
      metrics: [
        Metric(
          title: 'Сегодня',
          value: stats.todayReviews,
          max: stats.totalCards,
        ),
        Metric(
          title: 'Всего',
          value: stats.totalReviews,
          max: stats.totalCards,
        ),
      ],
    );
  }

  Widget _buildMetricsTable(DeckStatistics stats) {
    return  MetricTable(
      title: 'Показатели',
      metrics: {
        'Кол-во карточек:': stats.totalCards.toString(),
        'Средний интервал:': stats.avgInterval.toStringAsFixed(1),
        'К просмотру сегодня:': stats.todayReviews.toString(),
        'Показатель вспоминаемости:':
        '${stats.retentionRate.toStringAsFixed(1)}%',
      },
    );
  }

  Widget _buildProgressSection(BuildContext context, DeckStatistics stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Общий прогресс',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Прогресс изучения',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${stats.retentionRate.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: stats.retentionRate / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    stats.retentionRate < 50
                        ? Colors.red
                        : stats.retentionRate < 80
                        ? Colors.orange
                        : Colors.green,
                  ),
                  minHeight: 12,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${stats.learnedCards} из ${stats.totalCards}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Не изучено: ${stats.dueCards}',
                      style: TextStyle(
                        color: stats.dueCards > 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final deck = ref.watch(deckByIdProvider(id: currentDeck));
    final stats = ref.watch(deckStatisticsProvider(deckId: currentDeck));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Статистика ${deck.title}',
        ),
      ),
      body: stats.totalCards == 0
          ? _buildEmptyState()
          : _buildStatisticsContent(context, stats, deck)
    );
  }
}
