
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/dictionary_provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(dictionaryProvider);
    final notifier = ref.read(dictionaryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Словарь'),
      ),
      body: stateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (state) {
          final controller = notifier.searchController;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  controller: controller,
                  hintText: 'Поиск слова...',
                  leading: const Icon(Icons.search),
                  onChanged: (value) {
                    notifier.search(value);
                  },
                  onSubmitted: (value) {
                    if (value.trim().isEmpty) return;
                    notifier.saveHistory(value);
                  },
                ),

                const SizedBox(height: 12),

                if (state.history.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "История",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () => notifier.clearHistory(),
                        child: const Text("Очистить"),
                      ),
                    ],
                  ),

                if (state.history.isNotEmpty) const SizedBox(height: 8),

                if (state.history.isNotEmpty)
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.history.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        final item = state.history[index];
                        return InputChip(
                          label: Text(item),
                          onPressed: () {
                            controller.text = item;
                            notifier.search(item);
                          },
                          onDeleted: () {
                            // Удаление одного элемента истории — если нужно,
                            // можно добавить метод deleteHistoryItem()
                          },
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Результаты",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: ListView.separated(
                    itemCount: state.words.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final word = state.words[index];

                      return ListTile(
                        title: Text(word.word),
                        subtitle: Text("${word.furigana} — ${word.meaning}"),
                        trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.push("/word", extra: {"wordId": word.id});
                        },
                      );
                    },
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
