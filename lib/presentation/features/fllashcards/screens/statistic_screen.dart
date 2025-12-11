import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_practic/presentation/features/fllashcards/providers/stats_provider.dart';
import 'package:test_practic/presentation/shared/widgets/statistic/metric_table.dart';
import 'package:test_practic/presentation/shared/widgets/statistic/metric_bar_card.dart';
import 'package:test_practic/core/models/shared/metric.dart';

class DeckStatisticsScreen extends ConsumerWidget {
  final String currentDeck;

  const DeckStatisticsScreen({super.key, required this.currentDeck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticProvider(deckId: currentDeck));

    return Scaffold(
      appBar: AppBar(title: Text('Статистика')),
      body: stats.totalCards == 0
          ? Center(
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
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Прогресс изучения',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${stats.learnedCards} из ${stats.totalCards}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    'Не изучено: ${stats.dueCards}',
                                    style: TextStyle(
                                      color: stats.dueCards > 0
                                          ? Colors.red
                                          : Colors.green,
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
                  ),
                  const SizedBox(height: 24),
                  MetricTable(
                    title: 'Показатели',
                    metrics: {
                      'Кол-во карточек:': stats.totalCards.toString(),
                      'Средний интервал:': stats.avgInterval.toStringAsFixed(1),
                      'К просмотру сегодня:': stats.todayReviews.toString(),
                      'Показатель вспоминаемости:':
                          '${stats.retentionRate.toStringAsFixed(1)}%',
                    },
                  ),
                  const SizedBox(height: 24),
                  MetricBarCard(
                    title: 'Активность просмотра',
                    metrics: [
                      MetricModel(
                        title: 'Сегодня',
                        value: stats.todayReviews,
                        max: stats.totalCards,
                      ),
                      MetricModel(
                        title: 'Всего',
                        value: stats.totalReviews,
                        max: stats.totalCards,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  MetricBarCard(
                    title: 'Интервалы',
                    metrics: [
                      ...stats.intervalBuckets.entries.map((interval) {
                        return MetricModel(
                          title: interval.key,
                          value: interval.value,
                          max: stats.totalCards,
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
