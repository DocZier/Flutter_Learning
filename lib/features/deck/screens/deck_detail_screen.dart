import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/features/flashcard/widgets/flashcard_view.dart';
import 'package:test_practic/features/statistic/screen/statistic_screen.dart';
import 'package:test_practic/state/data_container.dart';

class DeckDetailsScreen extends StatefulWidget {
  final AppData appData;
  final String currentDeck;

  const DeckDetailsScreen({
    super.key,
    required this.appData,
    required this.currentDeck,
  });

  @override
  State<DeckDetailsScreen> createState() => _DeckDetailsScreenState();
}

class _DeckDetailsScreenState extends State<DeckDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appData.decks.where((deck) => deck.id == widget.currentDeck).first.title),
        actions: [
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              //TODO Add navigation to statistic screen
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeckStatisticsScreen(
                  widget.appData,
                  widget.currentDeck
                  ),
                ),
              );*/
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => {
              //TODO ADd navigation to study screen
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.appData.deleteDeck(widget.currentDeck);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.appData.decks.where((deck) => deck.id == widget.currentDeck).first.description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 8),
          Expanded(
            child: widget.appData.decks.where((deck) => deck.id == widget.currentDeck).first.flashcards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Колода пуста.', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.appData.decks.where((deck) => deck.id == widget.currentDeck).first.flashcards.length,
                    separatorBuilder: (context, index) => Divider(height: 8),
                    itemBuilder: (context, index) {
                      final card = widget.appData.decks.where((deck) => deck.id == widget.currentDeck).first.flashcards[index];

                      return CardListItem(
                        deckId: widget.currentDeck,
                        card: card,
                        deleteCard: widget.appData.deleteCard,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          //TODO Add navigation to add flashcard screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
