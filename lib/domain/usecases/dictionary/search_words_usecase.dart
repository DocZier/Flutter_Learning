import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class SearchWordsUseCase {
  final DictionaryRepository repository;

  SearchWordsUseCase(this.repository);

  Future<List<DictionaryWordModel>> execute(String query) async {
    return await repository.search(query);
  }
}