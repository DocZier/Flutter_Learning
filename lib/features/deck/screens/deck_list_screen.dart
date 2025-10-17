import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/features/deck/widgets/deck_view.dart';

class HomeScreen extends StatelessWidget {
  final List<Deck> decks;
  final void Function(String deckId) onTapEmpty;
  final void Function(String deckId) onTapFull;
  final void Function(String deckId) onLongPress;
  final void Function(Deck newDeck) addDeck;

  const HomeScreen({
    super.key,
    required this.decks,
    required this.addDeck,
    required this.onTapEmpty,
    required this.onTapFull,
    required this.onLongPress,
  });

  void _createNewDeck(BuildContext context) {
    String deckName = '';
    String deckDescription = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Новая колода'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckName = value,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (deckName.isNotEmpty) {
                addDeck(
                  Deck(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: deckName,
                    description: deckDescription,
                    flashcards: [],
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Колоды')),
      body: decks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Отсутствуют колоды',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: decks.length,
              itemBuilder: (_, index) {
                final deck = decks[index];
                final dueCount = deck.flashcards
                    .where(
                      (flashcard) =>
                          flashcard.nextReview.isBefore(DateTime.now()),
                    )
                    .length;
                final totalCount = deck.flashcards
                    .where(
                      (flashcard) =>
                          flashcard.nextReview.isAfter(DateTime.now()),
                    )
                    .length;

                return DeckListItem(
                  deck: deck,
                  onTapEmpty: onTapEmpty,
                  onTapFull: onTapFull,
                  onLongPress: onLongPress,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_createNewDeck(context)},
        child: Icon(Icons.add),
      ),
    );
  }
}
