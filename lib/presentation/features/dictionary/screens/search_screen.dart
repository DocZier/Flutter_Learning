
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/presentation/features/dictionary/states/search_state.dart';
import 'package:test_practic/presentation/shared/widgets/dictionary/kanji_list_item.dart';
import 'package:test_practic/presentation/shared/widgets/dictionary/word_list_item.dart';
import '../providers/search_provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(dictionarySearchProvider);
    final notifier = ref.read(dictionarySearchProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Словарь'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SegmentedButton<SearchMode>(
              segments: const [
                ButtonSegment<SearchMode>(
                  value: SearchMode.words,
                  label: Text('Слова'),
                ),
                ButtonSegment<SearchMode>(
                  value: SearchMode.kanji,
                  label: Text('Кандзи'),
                ),
              ],
              selected: <SearchMode>{notifier.searchMode},
              onSelectionChanged: (Set<SearchMode> newSelection) {
                if (newSelection.isNotEmpty) {
                  notifier.setSearchMode(newSelection.first);
                  if (newSelection.first == SearchMode.words) {
                    notifier.search('', submit: false);
                  } else {
                    notifier.search('', submit: false);
                  }
                }
              },
            ),
          ),
        ),
      ),
      body: stateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('Error in search: $error');
          return Center(child: Text('Ошибка поиска: ${error.toString()}'));
        },
          data:  (state) {
          final controller = notifier.searchController;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  controller: controller,
                  hintText: notifier.searchMode == SearchMode.words
                      ? 'Поиск слова...'
                      : 'Поиск кандзи по чтению...',
                  leading: const Icon(Icons.search),
                    onSubmitted: (value) {
                      if (value.trim().isEmpty) {
                        notifier.search('', submit: true);
                      } else {
                        notifier.search(value.trim(), submit: true);
                      }
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
                            notifier.search(item, submit: true);
                          },
                          onDeleted: () {
                          },
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    notifier.searchMode == SearchMode.words
                        ? "Результаты поиска слов"
                        : "Результаты поиска кандзи",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: notifier.searchMode == SearchMode.words
                      ? _buildWordResults(state.words, context)
                      : _buildKanjiResults(state.kanji, context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWordResults(List<DictionaryWordModel> words, BuildContext context) {
    if (words.isEmpty) {
      return const Center(child: Text('Ничего не найдено'));
    }

    return ListView.separated(
      itemCount: words.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final word = words[index];
        return WordListItem(
          word: word,
          onTap: () {
            context.push("/word", extra: {"word": word.word});
          },
        );
      },
    );
  }

  Widget _buildKanjiResults(List<KanjiReadingModel> kanjiList, BuildContext context) {
    if (kanjiList.isEmpty) {
      return const Center(child: Text('Ничего не найдено'));
    }

    return ListView.separated(
      itemCount: kanjiList.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final kanji = kanjiList[index];
        return KanjiListItem(
          kanji: kanji.kanji,
          reading: kanji.reading,
          onTap: () {
            context.push("/kanji", extra: {"kanji": kanji.kanji});
          },
        );
      },
    );
  }
}