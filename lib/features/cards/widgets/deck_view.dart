import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';

Widget DeckView(BuildContext context, List<Deck> decks) {
  if (decks.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.deck, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Отсутствуют колоды',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    itemCount: decks.length,
    itemBuilder: (context, index) {
      final deck = decks[index];
      final dueCount = deck.flashcards
          .where((flashcard) =>
      flashcard.nextReview == DateTime.now())
          .length;
      final totalCount = deck.flashcards
          .where((flashcard) =>
      flashcard.nextReview == null)
          .length;

      return Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: () {
            /*
            TODO
             if deck is empty - then create flashcards
             else - start test
             */
          },
          child: Row(
            spacing: 8.0,
            children: [
              Text(deck.title),
              Expanded(
                flex: 2,
                child: SizedBox.shrink(),
              ),
              Text(
                totalCount.toString(),
                style: TextStyle(color: totalCount > 0 ? Colors.green : Colors.grey),
              ),
              Text(
                dueCount.toString(),
                style: TextStyle(color: dueCount > 0 ? Colors.blue : Colors.grey),
              )
            ],
          ),
        ),
      );
    },
  );
}