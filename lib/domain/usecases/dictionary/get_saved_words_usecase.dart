import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetSavedWordsUseCase {
  final DictionaryRepository repository;

  GetSavedWordsUseCase(this.repository);

  List<DictionaryWordModel> execute() {
    return repository.getSavedWords();
  }
}
