import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';

enum SearchMode { words, kanji }

class SearchState {
  final List<DictionaryWordModel> words;
  final List<KanjiReadingModel> kanji;
  final List<String> history;
  final SearchMode searchMode;

  SearchState({
    required this.words,
    required this.kanji,
    required this.history,
    required this.searchMode,
  });

  SearchState copyWith({
    List<DictionaryWordModel>? words,
    List<KanjiReadingModel>? kanji,
    List<String>? history,
    SearchMode? searchMode,
  }) {
    return SearchState(
      words: words ?? this.words,
      kanji: kanji ?? this.kanji,
      history: history ?? this.history,
      searchMode: searchMode ?? this.searchMode,
    );
  }
}