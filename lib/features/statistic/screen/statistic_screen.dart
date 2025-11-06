import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/features/statistic/widgets/metric_table.dart';
import 'package:test_practic/features/statistic/widgets/metric_bar_card.dart';
import 'package:test_practic/models/metric.dart';
import 'package:test_practic/state/data_container.dart';
import '../../../models/decks.dart';
import '../../../state/data_repository.dart';

class DeckStatisticsScreen extends StatefulWidget {
  final String currentDeck;

  const DeckStatisticsScreen({super.key, required this.currentDeck});

  @override
  State<DeckStatisticsScreen> createState() => _DeckStatisticsScreenState();
}

class _DeckStatisticsScreenState extends State<DeckStatisticsScreen> {
  void update() => setState(() => {});

  @override
  void initState() {
    GetIt.I.isReady<AppDataRepository>().then(
      (_) => GetIt.I<AppDataRepository>().addListener(update),
    );
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I<AppDataRepository>().removeListener(update);
    super.dispose();
  }

  int totalCards = 0;
  int dueCards = 0;
  int learnedCards = 0;
  double averageInterval = 0;
  double retentionRate = 0;
  int todayReviews = 0;
  int totalReviews = 0;

  void _calculateStats(Deck deck) {
    totalCards = deck.flashcards.length;

    if (totalCards != 0) {
      dueCards = deck.flashcards
          .where((card) => card.nextReview.isBefore(DateTime.now()))
          .length;
      learnedCards = totalCards - dueCards;

      averageInterval =
          deck.flashcards
              .map((card) => card.interval.toDouble())
              .reduce((a, b) => a + b) /
          totalCards;

      retentionRate = (learnedCards / totalCards) * 100;

      todayReviews = deck.flashcards
          .where((card) => card.nextReview.day == DateTime.now().day)
          .length;

      totalReviews = deck.flashcards.where((card) => card.interval > 0).length;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = GetIt.I<AppData>();

    _calculateStats(appData.getDeckById(widget.currentDeck));

    final intervalBuckets = <String, int>{
      '0-1 дней': 0,
      '2-7 дней': 0,
      '8-30 дней': 0,
      '31+ дней': 0,
    };

    for (var card in appData.getDeckById(widget.currentDeck).flashcards) {
      if (card.interval <= 1) {
        intervalBuckets['0-1 дней'] = intervalBuckets['0-1 дней']! + 1;
      } else if (card.interval <= 7) {
        intervalBuckets['2-7 дней'] = intervalBuckets['2-7 дней']! + 1;
      } else if (card.interval <= 30) {
        intervalBuckets['8-30 дней'] = intervalBuckets['8-30 дней']! + 1;
      } else {
        intervalBuckets['31+ дней'] = intervalBuckets['31+ дней']! + 1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Статистика ${appData.getDeckById(widget.currentDeck).title}',
        ),
      ),
      body: totalCards == 0
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Прогресс изучения',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${retentionRate.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: retentionRate / 100,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              retentionRate < 50
                                  ? Colors.red
                                  : retentionRate < 80
                                  ? Colors.orange
                                  : Colors.green,
                            ),
                            minHeight: 12,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$learnedCards из $totalCards',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Не изучено: $dueCards',
                                style: TextStyle(
                                  color: dueCards > 0
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

                  SizedBox(height: 24),
                  MetricTable(
                    title: 'Показатели',
                    metrics: {
                      'Кол-во карточек:': totalCards.toString(),
                      'Средний интервал:': averageInterval.toStringAsFixed(1),
                      'К просмотру сегодня:': todayReviews.toString(),
                      'Показатель вспоминаемости:':
                          '${retentionRate.toStringAsFixed(1)}%',
                    },
                  ),

                  SizedBox(height: 24),
                  MetricBarCard(
                    title: 'Активность просмотра',
                    metrics: [
                      Metric(
                        title: 'Сегодня',
                        value: todayReviews,
                        max: totalCards,
                      ),
                      Metric(
                        title: 'Всего',
                        value: totalReviews,
                        max: totalCards,
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  MetricBarCard(
                    title: 'Интервалы',
                    metrics: [
                      ...intervalBuckets.entries.map((interval) {
                        return Metric(
                          title: interval.key,
                          value: interval.value,
                          max: totalCards,
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
