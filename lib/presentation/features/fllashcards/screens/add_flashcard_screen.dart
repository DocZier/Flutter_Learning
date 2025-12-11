import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/add_card_provider.dart';

const flashcardIcon = 'https://cdn-icons-png.flaticon.com/512/6726/6726775.png';

class AddCardScreen extends ConsumerWidget {
  final String currentDeck;

  const AddCardScreen({super.key, required this.currentDeck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(addCardProvider.notifier);

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
          key:  form.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: form.question,
                decoration: InputDecoration(
                  labelText: 'Вопрос',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите вопрос';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              TextFormField(
                controller: form.answer,
                decoration: InputDecoration(
                  labelText: 'Ответ',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите ответ';
                  }
                  return null;
                },
              ),

              Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (!form.formKey.currentState!.validate()) {
                    return;
                  }

                  ref.read(addCardProvider.notifier).addCard(
                    currentDeck,
                    form.question.text,
                    form.answer.text,
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Карточка добавлена")));
                  form.question.clear();
                  form.answer.clear();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Добавить карточку'),
              ),
              SizedBox(height: 32)
            ],
          ),
        ),
      ),
    );
  }
}
