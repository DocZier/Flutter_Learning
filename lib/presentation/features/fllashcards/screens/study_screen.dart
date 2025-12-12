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
    final studyState = ref.watch(studyProvider(currentDeck));

    return studyState.when(
      loading: () => Scaffold(
        appBar: AppBar(title: Text('Изучение')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: Text('Изучение')),
        body: Center(child: Text('Ошибка: $error')),
      ),
      data: (state) => Scaffold(
        appBar: AppBar(
          title: Text(state.deckTitle),
        ),
        body: state.remainingCards == 0
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: finaleIcon,
                height: 160,
                width: 160,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
                fit: BoxFit.contain,
              ),
              const Text(
                'Все карточки изучены.\nПриходите завтра.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  Router.neglect(context, () {
                    context.pushReplacement(
                      '/deck_stats',
                      extra: {'deckId': currentDeck},
                    );
                  });
                },
                child: const Text('Статистика'),
              ),
            ],
          ),
        )
            : InkWell(
          onTap: () {
            ref.read(studyProvider(currentDeck).notifier).flip();
          },
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  state.isFlipped && state.currentCard != null
                      ? state.currentCard!.answer
                      : state.currentCard?.question ?? 'Нет карточек для изучения',
                  style: const TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: state.isFlipped && state.currentCard != null
            ? Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => ref
                    .read(studyProvider(currentDeck).notifier)
                    .updateCard(2, currentDeck),
                child: const Text('Сложно'),
              ),
              ElevatedButton(
                onPressed: () => ref
                    .read(studyProvider(currentDeck).notifier)
                    .updateCard(4, currentDeck),
                child: const Text('Хорошо'),
              ),
              ElevatedButton(
                onPressed: () => ref
                    .read(studyProvider(currentDeck).notifier)
                    .updateCard(5, currentDeck),
                child: const Text('Легко'),
              ),
            ],
          ),
        )
            : null,
      ),
    );
  }
}