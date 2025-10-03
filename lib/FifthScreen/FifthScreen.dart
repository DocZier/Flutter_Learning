import 'package:flutter/material.dart';

class AddDescriptionScreen extends StatefulWidget {
  const AddDescriptionScreen({
    super.key,
    required this.currentDescription,
  });

  final String currentDescription;

  @override
  State<AddDescriptionScreen> createState() => _AddDescriptionScreenState();
}

class _AddDescriptionScreenState extends State<AddDescriptionScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.currentDescription);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveDescription() {
    Navigator.pop(context, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить описание'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Введите описание...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveDescription,
                child: const Text('Сохранить'),
              )
            ],
          ),
        ),
      ),
    );
  }
}