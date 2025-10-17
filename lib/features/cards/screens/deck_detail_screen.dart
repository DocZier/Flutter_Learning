import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';


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
          )
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
                  Text(
                    'Колода пуста.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
                : ListView.separated(
              itemCount: widget.deck.flashcards.length,
              separatorBuilder: (context, index) => Divider(height: 8),
              itemBuilder: (context, index) {
                final card = widget.deck.flashcards[index];
                final formattedDate =
                    '${card.nextReview.day}.'
                    '${card.nextReview.month}.'
                    '${card.nextReview.year} ';

                return ListTile(
                  title: Text(
                    'Карточка №${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Вопрос: ${card.question}'),
                      SizedBox(height: 4),
                      Text('Ответ: ${card.answer}'),
                      SizedBox(height: 4),
                      Text('Следующее повторение: $formattedDate'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => widget.deleteCard(
                          widget.deck.id,
                          card.id
                        ),
                      ),
                    ],
                  ),
                  onTap: null
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