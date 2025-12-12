import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class SaveWordUseCase {
  final DictionaryRepository repository;

  SaveWordUseCase(this.repository);

  void execute(int id) {
    repository.saveWord(id);
  }
}
