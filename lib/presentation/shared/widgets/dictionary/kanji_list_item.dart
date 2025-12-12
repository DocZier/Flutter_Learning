import 'package:flutter/material.dart';

class KanjiListItem extends StatelessWidget {
  final String kanji;
  final String reading;
  final VoidCallback onTap;

  const KanjiListItem({
    super.key,
    required this.kanji,
    required this.reading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        kanji,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Чтение: $reading',
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}