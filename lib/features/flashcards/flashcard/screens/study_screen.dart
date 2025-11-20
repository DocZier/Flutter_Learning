import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/features/flashcards/flashcard/provider/study_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_practic/provider/app_data_provider.dart';

const finaleIcon = 'https://cdn-icons-png.flaticon.com/512/9092/9092852.png';

class StudyScreen extends ConsumerWidget {
  final String currentDeck;

  const StudyScreen({super.key, required this.currentDeck});

  void _handleAnswer(
    int quality,
    currentCard,
    dueCards,
    WidgetRef ref,
  ) {
    if (currentCard != null) {
      ref.read(studyProvider.notifier).flip();
      ref.read(appDataProvider.notifier).updateCard(currentDeck, currentCard!, quality);
      if (currentCard!.nextReview.isAfter(DateTime.now())) dueCards.removeAt(0);

      if (dueCards.isNotEmpty) {
        currentCard = dueCards[0];
      } else {
        currentCard = null;
      }

    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.read(appDataProvider.notifier).getDeckById(currentDeck);
    final isFlipped = ref.watch(studyProvider);

    final dueCards = deck.flashcards
        .where((flashcard) => flashcard.nextReview.isBefore(DateTime.now()))
        .toList();
    final currentCard = dueCards.isNotEmpty ? dueCards[0] : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.title),
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
                        /*Navigator.pop(context)*/
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
      body: currentCard == null
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
              onTap: () {ref.read(studyProvider.notifier).flip();},
              child: Card(
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      isFlipped ? currentCard.answer : currentCard.question,
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: isFlipped
          ? Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(2, currentCard, dueCards, ref ),
                    child: Text('Сложно'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(4, currentCard, dueCards, ref ),
                    child: Text('Хорошо'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(5, currentCard, dueCards, ref ),
                    child: Text('Легко'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
