import 'package:flutter/material.dart';
import 'package:test_practic/utils/test_data.dart';
import 'package:test_practic/test/test_detail.dart';
import 'package:test_practic/question/question_screen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.title});

  final String title;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<Test> _tests = [];

  void _addTest() async {
    final newTest = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionScreen(title: 'Создать тест')),
    );
    if (newTest != null) {
      setState(() {
        _tests.add(newTest);
      });
    }
  }

  void _removeTest(int index) {
    setState(() {
      if (index >= 0 && index < _tests.length) {
        _tests.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _tests
              .map((test) {
            final index = _tests.indexOf(test);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestDetailScreen(test: test),
                  ),
                );
              },
              child: Card(
                key: ValueKey(test),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          test.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeTest(index),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTest,
        child: const Icon(Icons.add),
      ),
    );
  }
}