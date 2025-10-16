import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';
import 'package:test_practic/features/cards/widgets/deck_view.dart';

class AddCardScreen extends StatefulWidget {
  final String deckId;

  const AddCardScreen({
    super.key,
    required this.deckId
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
                  //TODO add flashcard to deck
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Добавить карточку'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}