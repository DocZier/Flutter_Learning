import 'package:flutter/material.dart';
import 'package:test_practic/models/flashcards.dart';

class CardListItem extends StatelessWidget {
  final String deckId;
  final Flashcard card;
  final void Function(String deckd, String cardID) deleteCard;

  const CardListItem({
    super.key,
    required this.deckId,
    required this.card,
    required this.deleteCard,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${card.nextReview.day}.'
        '${card.nextReview.month}.'
        '${card.nextReview.year} ';

    return ListTile(
      title: Text(
        'Карточка №${card.id}',
        style: TextStyle(fontWeight: FontWeight.bold),
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
            onPressed: () => deleteCard(deckId, card.id),
          ),
        ],
      ),
      onTap: null,
    );
  }
}
