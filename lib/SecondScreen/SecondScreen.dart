import 'package:flutter/material.dart';
import 'package:test_practic/ThirdScreen/ThirdScreen.dart';

class Question1Screen extends StatefulWidget {
  const Question1Screen({super.key});

  @override
  State<Question1Screen> createState() => _Question1ScreenState();
}

class _Question1ScreenState extends State<Question1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вопрос 1'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Какой виджет используется для отображения текстовой информации?',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Question2Screen(answer1: 'Text'),
                  ),
                );
              },
              child: const Text('Text'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Question2Screen(answer1: 'Button'),
                  ),
                );
              },
              child: const Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}