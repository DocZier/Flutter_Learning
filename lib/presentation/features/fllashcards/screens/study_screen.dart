import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../providers/study_provider.dart';

const finaleIcon = 'https://cdn-icons-png.flaticon.com/512/9092/9092852.png';

class StudyScreen extends ConsumerWidget {
  final String currentDeck;

  const StudyScreen({super.key, required this.currentDeck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyProvider(currentDeck));

    return Scaffold(
      appBar: AppBar(
        title: Text(state.deckTitle)
      ),
      body: ref.watch(studyProvider(currentDeck)).remainingCards == 0
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
                        ref.read(studyProvider(currentDeck).notifier).updateCard(2, currentDeck),
                    child: Text('Сложно'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(studyProvider(currentDeck).notifier).updateCard(4, currentDeck),
                    child: Text('Хорошо'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(studyProvider(currentDeck).notifier).updateCard(5, currentDeck),
                    child: Text('Легко'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
