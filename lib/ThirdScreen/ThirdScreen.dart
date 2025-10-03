import 'package:flutter/material.dart';
import 'package:test_practic/FourthScreen/FourthScreen.dart';

class Question2Screen extends StatefulWidget {
  const Question2Screen({super.key, required this.answer1});

  final String answer1;

  @override
  State<Question2Screen> createState() => _Question2ScreenState();
}

class _Question2ScreenState extends State<Question2Screen> {
  bool _isOption1Selected = false;
  bool _isOption2Selected = false;
  bool _isOption3Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вопрос 2'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Какие виджеты используются для расположения элементов?',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOption1Selected = !_isOption1Selected;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOption1Selected ? Colors.blue : null,
              ),
              child: const Text('Column'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOption2Selected = !_isOption2Selected;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOption2Selected ? Colors.blue : null,
              ),
              child: const Text('Row'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isOption3Selected = !_isOption3Selected;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isOption3Selected ? Colors.blue : null,
              ),
              child: const Text('Container'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Question3Screen(
                      answer1: widget.answer1,
                      answer2: [
                        if (_isOption1Selected) 'Column',
                        if (_isOption2Selected) 'Row',
                        if (_isOption3Selected) 'Container'
                      ].join(', '),
                    ),
                  ),
                );
              },
              child: const Text('Далее'),
            ),
          ],
        ),
      ),
    );
  }
}