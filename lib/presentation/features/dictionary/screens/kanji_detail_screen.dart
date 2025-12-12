import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/presentation/features/dictionary/providers/kanji_provider.dart';
import 'package:test_practic/presentation/shared/widgets/dictionary/kanji_example_item.dart';

class KanjiDetailScreen extends ConsumerWidget {
  final String kanji;

  const KanjiDetailScreen({super.key, required this.kanji});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kanjiAsync = ref.watch(kanjiDetailProvider(kanji));

    return Scaffold(
      appBar: AppBar(
        title: kanjiAsync.when(
          data: (data) => Text(data.kanji.kanji),
          loading: () => const Text("Загрузка..."),
          error: (_, __) => const Text("Ошибка"),
        ),
      ),
      body: kanjiAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (data) {
          final kanjiDetail = data.kanji;
          final examples = data.examples;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildKanjiHeader(kanjiDetail),
              const SizedBox(height: 24),
              _buildKanjiDetails(context, kanjiDetail),
              if (examples.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildExamplesHeader(context),
                const SizedBox(height: 12),
                ...examples.map((example) => KanjiExampleItem(example: example)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildKanjiHeader(KanjiDetailModel kanji) {
    return Column(
      children: [
        Text(
          kanji.kanji,
          style: const TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Уровень JLPT: ${kanji.jlptLevel.isNotEmpty ? kanji.jlptLevel : 'Нет данных'}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Класс: ${kanji.grade}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Черты: ${kanji.strokes.length}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildKanjiDetails(BuildContext context, KanjiDetailModel kanji) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Значения',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: kanji.meanings.map((meaning) {
                return Chip(
                  label: Text(meaning),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Кунъёми (Японское чтение)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...kanji.kunyomi.map((reading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reading.reading,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: reading.meanings.map((meaning) {
                        return Chip(
                          label: Text(meaning),
                          backgroundColor: Colors.green.withOpacity(0.1),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
            if (kanji.kunyomi.isNotEmpty) const SizedBox(height: 16),
            Text(
              'Онъёми (Китайское чтение)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: kanji.onyomi.map((reading) {
                return Chip(
                  label: Text(reading.reading),
                  backgroundColor: Colors.orange.withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamplesHeader(BuildContext context,) {
    return Text(
      'Примеры слов',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}