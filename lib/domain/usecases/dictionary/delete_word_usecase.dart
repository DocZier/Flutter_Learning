import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class DeleteWordUseCase {
  final DictionaryRepository repository;

  DeleteWordUseCase(this.repository);

  void execute(String word) {
    repository.deleteWord(word);
  }
}