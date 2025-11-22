import 'package:flutter/material.dart';
import 'package:test_practic/utils/question_data.dart';
import 'package:test_practic/utils/answer_data.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({super.key, required this.title});

  final String title;

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<Answer> _answers = [];

  void _addAnswer() async {
    final text = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Введите ответ'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );

    if (text != null && text.isNotEmpty) {
      setState(() {
        _answers.add(Answer(text: text));
      });
    }
  }

  void _removeAnswer(int index) {
    setState(() {
      _answers.removeAt(index);
    });
  }

  void _saveQuestion() {
    if (_questionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите текст вопроса')),
      );
      return;
    }

    if (_answers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Добавьте хотя бы один ответ')),
      );
      return;
    }

    Navigator.pop(
      context,
      Question(
        text: _questionController.text,
        answers: _answers,
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
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Текст вопроса',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _answers.isEmpty
                ? const Center(child: Text('Добавьте ответы'))
                : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: _answers.length,
              separatorBuilder: (_,__) => Divider(height: 10),
              itemBuilder: (context, index) {
                final answer = _answers[index];
                return Card(
                  key: ValueKey(answer),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(answer.text),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeAnswer(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAnswer,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _answers.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _saveQuestion,
          child: const Text('Сохранить вопрос'),
        ),
      )
          : null,
    );
  }
}