import 'package:flutter/material.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({
    super.key,
    required this.currentName,
    required this.currentNickname,
  });

  final String currentName;
  final String currentNickname;

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  late TextEditingController _nameController;
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _nicknameController = TextEditingController(text: widget.currentNickname);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final newName = _nameController.text;
    final newNickname = _nicknameController.text;

    Navigator.pop(context, {
      'name': newName,
      'nickname': newNickname
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменить данные'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(
                controller: _nameController,
                labelText: 'Имя',
                hintText: 'Введите ваше имя',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _nicknameController,
                labelText: 'Никнейм',
                hintText: 'Введите ваш никнейм',
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _handleSubmit,
                child: const Text(
                  'Подтвердить изменения',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(fontSize: 16.0),
    );
  }
}