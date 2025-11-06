import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/models/flashcards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_practic/state/data_container.dart';

import '../../../state/data_provider.dart';
import '../../../state/data_repository.dart';

const flashcardIcon = 'https://cdn-icons-png.flaticon.com/512/6726/6726775.png';

class AddCardScreen extends StatefulWidget {
  final String currentDeck;

  const AddCardScreen({
    super.key,
    required this.currentDeck,
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
      appBar: AppBar(
        title: Row(
          spacing: 8,
          children: [
            CachedNetworkImage(
              imageUrl: flashcardIcon,
              height: 30,
              width: 30,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              fit: BoxFit.contain,
            ),
            Text('Создать новую карточку'),
          ],
        ),
      ),
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
                  AppDataLogic.of(context).appDataRepository.addCard(
                    widget.currentDeck,
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
                onPressed: () => Router.neglect(context, () {
                  context.go('/home');
                }),
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
