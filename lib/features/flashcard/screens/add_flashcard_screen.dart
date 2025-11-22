import 'package:flutter/material.dart';
import 'package:test_practic/models/flashcards.dart';

class AddCardScreen extends StatefulWidget {
  final String deckId;
  final void Function(String deckId, Flashcard card) addCard;
  final void Function() navigateToList;

  const AddCardScreen({
    super.key,
    required this.deckId,
    required this.addCard,
    required this.navigateToList,
  });

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создать новую карточку')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Вопрос',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: 'Ответ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  widget.addCard(
                    widget.deckId,
                    Flashcard(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      question: _questionController.text,
                      answer: _answerController.text,
                      interval: 1,
                      easeFactor: 2.5,
                      nextReview: DateTime.now(),
                    ),
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Карточка добавлена")));
                  _questionController.clear();
                  _answerController.clear();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Добавить карточку'),
              ),
              Divider(height: 8.0),
              ElevatedButton(
                onPressed: () => widget.navigateToList(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Вернуться на главный экран'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
