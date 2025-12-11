import '../../../../core/models/dictionary/dictionary_model.dart';

class WordState {
  final DictionaryWordModel word;

  WordState({required this.word});

  WordState copyWith({DictionaryWordModel? word}) {
    return WordState(word: word ?? this.word);
  }
}