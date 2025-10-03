import 'package:flutter/material.dart';

class ChangeBackgroundScreen extends StatefulWidget {
  const ChangeBackgroundScreen({
    super.key,
    required this.currentColor,
  });

  final Color currentColor;

  @override
  State<ChangeBackgroundScreen> createState() => _ChangeBackgroundScreenState();
}

class _ChangeBackgroundScreenState extends State<ChangeBackgroundScreen> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _confirmSelection() {
    Navigator.pop(context, _selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор фона'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Выберите цвет фона:'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildColorOption(Colors.deepPurple),
                  _buildColorOption(Colors.indigoAccent),
                  _buildColorOption(Colors.lightGreen),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _confirmSelection,
                child: const Text('Применить'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () => _selectColor(color),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: _selectedColor == color ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}