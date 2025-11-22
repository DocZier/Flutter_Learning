import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/features/flashcard/widgets/flashcard_view.dart';

class DeckDetailsScreen extends StatefulWidget {
  final Deck deck;
  final void Function(String deckId) navigateToForm;
  final void Function(String deckId, String cardId) deleteCard;
  final void Function(String deckId) deleteDeck;
  final void Function(String deckId) navigateToStudy;

  const DeckDetailsScreen({
    super.key,
    required this.deck,
    required this.navigateToForm,
    required this.navigateToStudy,
    required this.deleteCard,
    required this.deleteDeck,
  });

  @override
  State<DeckDetailsScreen> createState() => _DeckDetailsScreenState();
}

class _DeckDetailsScreenState extends State<DeckDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.title),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => widget.navigateToStudy(widget.deck.id),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.deleteDeck(widget.deck.id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.deck.description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(height: 8),
          Expanded(
            child: widget.deck.flashcards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Колода пуста.', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.deck.flashcards.length,
                    separatorBuilder: (context, index) => Divider(height: 8),
                    itemBuilder: (context, index) {
                      final card = widget.deck.flashcards[index];

                      return CardListItem(
                        deckId: widget.deck.id,
                        card: card,
                        deleteCard: widget.deleteCard,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.navigateToForm(widget.deck.id),
        child: Icon(Icons.add),
      ),
    );
  }
}
