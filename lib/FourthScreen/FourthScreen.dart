import 'package:flutter/material.dart';
import 'package:test_practic/FifthScreen/FifthScreen.dart';

class Question3Screen extends StatefulWidget {
  const Question3Screen({
    super.key,
    required this.answer1,
    required this.answer2,
  });

  final String answer1;
  final String answer2;

  @override
  State<Question3Screen> createState() => _Question3ScreenState();
}

class _Question3ScreenState extends State<Question3Screen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вопрос 3'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                  'Сколько основных контейнеров было'
                  ' рассмотрено в методическом указании?',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('-'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      answer1: widget.answer1,
                      answer2: widget.answer2,
                      answer3: _counter.toString(),
                    ),
                  ),
                );
              },
              child: const Text('Проверить'),
            ),
          ],
        ),
      ),
    );
  }
}