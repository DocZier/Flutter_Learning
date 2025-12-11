import 'package:test_practic/core/models/dictionary/dictionary_model.dart';

class DictionaryState {
  final List<DictionaryWordModel> words;
  final List<String> history;

  DictionaryState({
    required this.words,
    required this.history,
  });

  DictionaryState copyWith({
    List<DictionaryWordModel>? words,
    List<String>? history,
  }) {
    return DictionaryState(
      words: words ?? this.words,
      history: history ?? this.history,
    );
  }
}