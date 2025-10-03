import 'package:flutter/material.dart';

class ChangeTextScreen extends StatefulWidget {
  const ChangeTextScreen({
    super.key,
    required this.currentColor,
    required this.currentSize,
  });

  final Color currentColor;
  final double currentSize;

  @override
  State<ChangeTextScreen> createState() => _ChangeTextScreenState();
}

class _ChangeTextScreenState extends State<ChangeTextScreen> {
  late Color _selectedColor;
  late double _fontSize;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
    _fontSize = widget.currentSize;
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _updateFontSize(double value) {
    setState(() {
      _fontSize = value;
    });
  }

  void _confirmChanges() {
    Navigator.pop(context, {
      'color': _selectedColor,
      'size': _fontSize
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка текста'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Цвет текста:'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildColorOption(Colors.black),
                  _buildColorOption(Colors.red.shade900)
                ],
              ),
              const SizedBox(height: 20),
              const Text('Размер текста:'),
              const SizedBox(height: 10),
              Slider(
                value: _fontSize,
                min: 12,
                max: 24,
                divisions: 12,
                label: _fontSize.round().toString(),
                onChanged: _updateFontSize,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _confirmChanges,
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
        width: 40,
        height: 40,
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