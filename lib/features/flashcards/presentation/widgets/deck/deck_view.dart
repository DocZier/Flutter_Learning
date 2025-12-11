import 'package:flutter/material.dart';
import 'package:test_practic/features/flashcards/data/model/flashcards_model.dart';

import '../../../data/model/deck_model.dart';

class DeckListItem extends StatelessWidget {
  final Deck deck;
  final List<Flashcard> flashcards;
  final void Function(String deckId) onTapEmpty;
  final void Function(String deckId) onTapFull;
  final void Function(String deckId) onLongPress;

  const DeckListItem({
    super.key,
    required this.deck,
    required this.flashcards,
    required this.onTapEmpty,
    required this.onTapFull,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final dueCount = flashcards
        .where((flashcard) => flashcard.nextReview.isBefore(DateTime.now()))
        .length;
    final totalCount = flashcards
        .where((flashcard) => flashcard.nextReview.isAfter(DateTime.now()))
        .length;

    return Card(
      child: InkWell(
        onTap: () =>
            flashcards.isEmpty ? onTapEmpty(deck.id) : onTapFull(deck.id),
        onLongPress: () => onLongPress(deck.id),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Row(
            spacing: 8.0,
            children: [
              Text(
                deck.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(flex: 1, child: SizedBox()),
              Text(
                totalCount.toString(),
                style: Theme.of(context).textTheme.headlineSmall?.apply(
                  color: totalCount > 0 ? Colors.green : Colors.grey,
                ),
              ),
              Text(
                dueCount.toString(),
                style: Theme.of(context).textTheme.headlineSmall?.apply(
                  color: dueCount > 0 ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
