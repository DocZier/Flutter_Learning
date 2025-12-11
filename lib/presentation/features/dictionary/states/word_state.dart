import '../../../../core/models/dictionary/dictionary_model.dart';

class WordState {
  final DictionaryWord word;

  WordState({required this.word});

  WordState copyWith({DictionaryWord? word}) {
    return WordState(word: word ?? this.word);
  }
}