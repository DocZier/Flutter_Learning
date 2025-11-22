import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.answer1,
    required this.answer2,
    required this.answer3,
  });

  final String answer1;
  final String answer2;
  final String answer3;

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;

    if (answer1 == 'Text') correctAnswers++;
    if (answer2.contains('Column')
        && answer2.contains('Row')
        && !answer2.contains('Container')) {
      correctAnswers++;
    }
    if (answer3 == '2') correctAnswers++;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Вы ответили правильно на $correctAnswers из 3 вопросов',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Ваш ответ на 1 вопрос: $answer1',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Ваш ответ на 2 вопрос: $answer2',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Ваш ответ на 3 вопрос: $answer3',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Пройти тест еще раз'),
            ),
          ],
        ),
      ),
    );
  }
}