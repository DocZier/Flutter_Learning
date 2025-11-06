import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/features/flashcard/widgets/flashcard_view.dart';
import 'package:test_practic/state/data_repository.dart';
import '../../../state/data_container.dart';

class DeckDetailsScreen extends StatefulWidget {
  final String currentDeck;

  const DeckDetailsScreen({super.key, required this.currentDeck});

  @override
  State<DeckDetailsScreen> createState() => _DeckDetailsScreenState();
}

class _DeckDetailsScreenState extends State<DeckDetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
    final appData = GetIt.I<AppData>();
    final appDataRepository = GetIt.I<AppDataRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(appData.getDeckById(widget.currentDeck).title),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              context.push(
                '/deck_stats',
                extra: {'deckId': widget.currentDeck},
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Router.neglect(context, () {
                context.pushReplacement(
                  '/study',
                  extra: {'deckId': widget.currentDeck},
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
              appDataRepository.deleteDeck(widget.currentDeck);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              appData.getDeckById(widget.currentDeck).description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 8),
          Expanded(
            child: appData.getDeckById(widget.currentDeck).flashcards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Колода пуста.', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: appData
                        .getDeckById(widget.currentDeck)
                        .flashcards
                        .length,
                    separatorBuilder: (context, index) => Divider(height: 8),
                    itemBuilder: (context, index) {
                      final card = appData
                          .getDeckById(widget.currentDeck)
                          .flashcards[index];

                      return CardListItem(
                        deckId: widget.currentDeck,
                        card: card,
                        deleteCard: (deckId, cardId) {
                          setState(() {
                            appDataRepository.deleteCard(deckId, cardId);
                          });
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
            context.go('/add_flashcard', extra: {'deckId': widget.currentDeck});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
