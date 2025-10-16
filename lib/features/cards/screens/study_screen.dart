import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';
import 'package:test_practic/features/cards/models/flashcards.dart';
import 'package:test_practic/features/cards/widgets/deck_view.dart';

class StudyScreen extends StatefulWidget {
  final String deckId;

  const StudyScreen({
    super.key,
    required this.deckId
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  Deck deck = Deck(
      id: '261839',
      title: 'Новая колода',
      description: 'Описание новой колоды',
      flashcards: [
        Flashcard(
            id: '124',
            question: "Вопрос",
            answer: "Ответ",
            interval: 0,
            easeFactor: 0
        )
      ]);
  List<Flashcard> dueCards = [];
  Flashcard? currentCard;
  bool isFlipped = false;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    dueCards = deck.flashcards.where(
            (flashcard) =>
            flashcard.nextReview == null ||
        flashcard.nextReview == DateTime.now()
    ).toList();
    currentCard = dueCards.isNotEmpty ? dueCards[0] : null;
    setState(() {});
  }

  void _flipCard() {
    setState(() => isFlipped = !isFlipped);
  }

  void _handleAnswer(int quality) {
    if (currentCard != null) {
      currentCard!.updateCard(quality);
      dueCards.removeAt(0);

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
        title: Text('Колода'),
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
                    '4. Оцените сложность\n'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body:
          currentCard == null ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Все карточки изучены.\nПриходите завтра.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () => {
                    //TODO return to home
                  },
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
        //TODO Change button style
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
            :
       null,
    );
  }
}