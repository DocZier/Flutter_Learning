import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetSavedWordsUseCase {
  final DictionaryRepository repository;

  GetSavedWordsUseCase(this.repository);

  Future<List<DictionaryWordModel>> execute() async {
    return await repository.getSavedWords();
  }
}