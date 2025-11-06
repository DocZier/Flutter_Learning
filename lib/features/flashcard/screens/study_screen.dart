import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/models/flashcards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_practic/state/data_container.dart';
import '../../../models/decks.dart';
import '../../../state/data_repository.dart';

const finaleIcon = 'https://cdn-icons-png.flaticon.com/512/9092/9092852.png';

class StudyScreen extends StatefulWidget {
  final String currentDeck;

  const StudyScreen({super.key, required this.currentDeck});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  void update() => setState(() => {});

  @override
  void initState() {
    GetIt.I.isReady<AppDataRepository>().then(
      (_) => GetIt.I<AppDataRepository>().addListener(update),
    );
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I<AppDataRepository>().removeListener(update);
    super.dispose();
  }

  List<Flashcard> dueCards = [];
  Flashcard? currentCard;
  bool isFlipped = false;

  void _loadCards(Deck deck) {
    dueCards = deck.flashcards
        .where((flashcard) => flashcard.nextReview.isBefore(DateTime.now()))
        .toList();
    currentCard = dueCards.isNotEmpty ? dueCards[0] : null;
    setState(() {});
  }

  void _flipCard() {
    setState(() => isFlipped = !isFlipped);
  }

  void _handleAnswer(
    int quality,
    void Function(Flashcard card, int quality) updateCard,
  ) {
    if (currentCard != null) {
      updateCard(currentCard!, quality);
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
    final appData = GetIt.I<AppData>();
    final appDataRepository = GetIt.I<AppDataRepository>();

    _loadCards(appData.getDeckById(widget.currentDeck));

    return Scaffold(
      appBar: AppBar(
        title: Text(appData.getDeckById(widget.currentDeck).title),
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
                      onPressed: () => {
                        context.pop(),
                        /*Navigator.pop(context)*/
                      },
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
                  CachedNetworkImage(
                    imageUrl: finaleIcon,
                    height: 160,
                    width: 160,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Все карточки изучены.\nПриходите завтра.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Router.neglect(context, () {
                        context.pushReplacement(
                          '/deck_stats',
                          extra: {'deckId': widget.currentDeck},
                        );
                      }),
                    },
                    child: Text('Статистика'),
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
                    onPressed: () =>
                        _handleAnswer(2, appDataRepository.updateCard),
                    child: Text('Сложно'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(4, appDataRepository.updateCard),
                    child: Text('Хорошо'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _handleAnswer(5, appDataRepository.updateCard),
                    child: Text('Легко'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
