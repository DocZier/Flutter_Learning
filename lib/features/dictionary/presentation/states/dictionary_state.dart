import 'package:test_practic/features/dictionary/data/model/dictionary_model.dart';

class DictionaryState {
  final List<DictionaryWord> words;
  final List<String> history;

  DictionaryState({
    required this.words,
    required this.history,
  });

  DictionaryState copyWith({
    List<DictionaryWord>? words,
    List<String>? history,
  }) {
    return DictionaryState(
      words: words ?? this.words,
      history: history ?? this.history,
    );
  }
}