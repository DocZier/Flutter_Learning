import 'package:flutter/material.dart';
import 'package:test_practic/answer/answer_screen.dart';
import 'package:test_practic/utils/test_data.dart';
import 'package:test_practic/utils/question_data.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.title});

  final String title;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<Question> _questions = [];

  void _addQuestion() async {
    final newQuestion = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnswerScreen(title: 'Добавить ответы')),
    );
    if (newQuestion != null) {
      setState(() {
        _questions.add(newQuestion);
      });
    }
  }

  void _removeQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _saveTest() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название теста')),
      );
      return;
    }

    if (_questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте хотя бы один вопрос')),
      );
      return;
    }

    Navigator.pop(
      context,
      Test(
        title: _titleController.text,
        questions: _questions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title)
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название теста',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _questions.map((question) =>
                    Card(
                      key: ValueKey(question),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(question.text),
                        subtitle: Text(
                            '${question.answers.length} ответов'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeQuestion(_questions.indexOf(question)),
                        ),
                    ),
                  )
              ).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _questions.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _saveTest,
          child: const Text('Создать тест'),
        ),
      )
          : null,
    );
  }
}
