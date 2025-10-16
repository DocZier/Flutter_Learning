import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';

Widget DeckView(
    BuildContext context,
    List<Deck> decks,
    void Function(String deckId) onTapEmpty,
    void Function(String deckId) onTapFull) {
  if (decks.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    itemBuilder: (_, index) {
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
            child: InkWell(
              onTap: () => deck.flashcards.isEmpty ?
              onTapEmpty(deck.id) : onTapFull(deck.id),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Row(
                  spacing: 8.0,
                  children: [
                    Text(
                        deck.title,
                        style: Theme.of(context).textTheme.headlineSmall
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      totalCount.toString(),
                      style: Theme.of(context).textTheme.headlineSmall?.apply(
                        color: totalCount > 0 ? Colors.green : Colors.grey
                      )
                    ),
                    Text(
                      dueCount.toString(),
                      style: Theme.of(context).textTheme.headlineSmall?.apply(
                          color: dueCount > 0 ? Colors.blue : Colors.grey
                      )
                    )
                  ],
                ),
              )
            ),
        );
    },
  );
}