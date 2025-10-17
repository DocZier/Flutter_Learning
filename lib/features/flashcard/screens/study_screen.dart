import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/models/flashcards.dart';

class StudyScreen extends StatefulWidget {
  final Deck deck;
  final void Function(Flashcard card, int quality) updateCard;
  final void Function() navigateToList;

  const StudyScreen({
    super.key,
    required this.deck,
    required this.updateCard,
    required this.navigateToList,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<Flashcard> dueCards = [];
  Flashcard? currentCard;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    dueCards = widget.deck.flashcards
        .where((flashcard) => flashcard.nextReview.isBefore(DateTime.now()))
        .toList();
    currentCard = dueCards.isNotEmpty ? dueCards[0] : null;
    setState(() {});
  }

  void _flipCard() {
    setState(() => isFlipped = !isFlipped);
  }

  void _handleAnswer(int quality) {
    if (currentCard != null) {
      widget.updateCard(currentCard!, quality);
      if (currentCard!.nextReview.isAfter(DateTime.now())) dueCards.removeAt(0);

      if (dueCards.isNotEmpty) {
        currentCard = dueCards[0];
      } else {
        currentCard = null;
      }
      isFlipped = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.deck.title}'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Правила'),
                  content: Text(
                    '1. Прочитайте вопрос\n'
                    '2. Ответьте на него\n'
                    '3. Переверните карточку\n'
                    '4. Оцените сложность\n',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: currentCard == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Все карточки изучены.\nПриходите завтра.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () => widget.navigateToList(),
                    child: Text('Вернуться назад'),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: _flipCard,
              child: Card(
                margin: EdgeInsets.all(24),
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      isFlipped ? currentCard!.answer : currentCard!.question,
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: isFlipped
          ? Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _handleAnswer(2),
                    child: Text('Сложно'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleAnswer(4),
                    child: Text('Хорошо'),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleAnswer(5),
                    child: Text('Легко'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
