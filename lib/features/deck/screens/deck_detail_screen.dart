import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/features/flashcard/widgets/flashcard_view.dart';
import 'package:test_practic/provider/app_data_provider.dart';
import '../../provider/deck_id_provider.dart';

class DeckDetailsScreen extends ConsumerWidget {
  final String currentDeck;

  const DeckDetailsScreen({super.key, required this.currentDeck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deck = ref.watch(deckByIdProvider(id: currentDeck));

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.title),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              context.push(
                '/deck_stats',
                extra: {'deckId': currentDeck},
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Router.neglect(context, () {
                context.pushReplacement(
                  '/study',
                  extra: {'deckId': currentDeck},
                );
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Router.neglect(context, () {
                context.go('/home');
              });
              ref.read(appDataProvider.notifier).deleteDeck(currentDeck);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              deck.description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 8),
          Expanded(
            child: deck.flashcards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Колода пуста.', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: deck
                        .flashcards
                        .length,
                    separatorBuilder: (context, index) => Divider(height: 8),
                    itemBuilder: (context, index) {
                      final card = deck
                          .flashcards[index];

                      return CardListItem(
                        deckId: currentDeck,
                        card: card,
                        deleteCard: (deckId, cardId) {
                          ref.read(appDataProvider.notifier).deleteCard(currentDeck, cardId);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Router.neglect(context, () {
            context.push('/add_flashcard', extra: {'deckId': currentDeck});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
