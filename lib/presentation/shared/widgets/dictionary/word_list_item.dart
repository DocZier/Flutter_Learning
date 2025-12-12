import 'package:flutter/material.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';

class WordListItem extends StatelessWidget {
  final DictionaryWordModel word;
  final VoidCallback onTap;

  const WordListItem({
    super.key,
    required this.word,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        word.word,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (word.furigana.isNotEmpty)
            Text(
              'Фуригана: ${word.furigana}',
              style: const TextStyle(color: Colors.grey),
            ),
          if (word.romanji.isNotEmpty)
            Text(
              'Ромадзи: ${word.romanji}',
              style: const TextStyle(color: Colors.grey),
            ),
          Text(
            'Значение: ${word.meaning}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}