import 'package:flutter/material.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';

class KanjiExampleItem extends StatelessWidget {
  final KanjiWordExampleModel example;

  const KanjiExampleItem({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example.word,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              example.reading,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Значения:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: example.meanings.map((meaning) {
                return Chip(
                  label: Text(meaning),
                  backgroundColor: Colors.purple.withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}