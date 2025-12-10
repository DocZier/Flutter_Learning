import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../provider/flashcard/study_provider.dart';

const finaleIcon = 'https://cdn-icons-png.flaticon.com/512/9092/9092852.png';

class StudyScreen extends ConsumerWidget {
  final String currentDeck;

  const StudyScreen({super.key, required this.currentDeck});

  void _handleAnswer(
    int quality,
    WidgetRef ref,
  ) {
    //TODO fix study through ref
    final currentCard = ref.watch(studyProvider(currentDeck)).currentCard;
    final dueCards = ref.watch(studyProvider(currentDeck)).dueCards;
    if (currentCard != null) {
      ref.read(studyProvider(currentDeck).notifier).updateCard(quality, currentDeck);

      if (currentCard.nextReview.isAfter(DateTime.now())) {
        ref.read(studyProvider(currentDeck).notifier).updateDueCards();
      }

      if (dueCards.isNotEmpty) {
        ref.read(studyProvider(currentDeck).notifier).setCurrentCard(dueCards[0]);
      } else {
        ref.read(studyProvider(currentDeck).notifier).setCurrentCard(null);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyProvider(currentDeck));

    return Scaffold(
      appBar: AppBar(
        title: Text(state.deckTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Правила'),
                  content: Text(
                    '1. Прочитайте вопрос\n'
                    '2. Ответьте на него\n'
                    '3. Переверните карточку\n'
                    '4. Оцените сложность\n',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => {
                        context.pop(),
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ref.watch(studyProvider(currentDeck)).currentCard == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: finaleIcon,
                    height: 160,
                    width: 160,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Все карточки изучены.\nПриходите завтра.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Router.neglect(context, () {
                        context.pushReplacement(
                          '/deck_stats',
                          extra: {'deckId': currentDeck},
                        );
                      }),
                    },
                    child: Text('Статистика'),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {ref.read(studyProvider(currentDeck).notifier).flip();},
              child: Card(
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      state.isFlipped ? ref.watch(studyProvider(currentDeck)).currentCard!.answer : ref.watch(studyProvider(currentDeck)).currentCard!.question,
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: state.isFlipped
          ? Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(2, ref ),
                    child: Text('Сложно'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(4,ref ),
                    child: Text('Хорошо'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(5, ref ),
                    child: Text('Легко'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
