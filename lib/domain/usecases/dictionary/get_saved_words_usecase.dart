import 'package:test_practic/core/models/dictionary/dictionary_entity.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class GetSavedWordsUseCase {
  final DictionaryRepository repository;

  GetSavedWordsUseCase(this.repository);

  List<DictionaryWordEntity> execute() {
    return repository.getSavedWords();
  }
}
