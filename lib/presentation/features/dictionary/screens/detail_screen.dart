import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/word_provider.dart';

class WordDetailScreen extends ConsumerWidget {
  final String word;

  const WordDetailScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(wordProvider(word));

    return Scaffold(
      appBar: AppBar(
        title: wordAsync.when(
          data: (data) => Text(data.word.word),
          loading: () => const Text("Загрузка..."),
          error: (_, __) => const Text("Ошибка"),
        ),
      ),
      body: wordAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (word) {
          print('${word.word}, ${word.word.word}, ${word.word.romanji}');
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  word.word.word,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  word.word.furigana,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  word.word.meaning,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 24),
                ...word.word.examples.map(
                      (example) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      example,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}