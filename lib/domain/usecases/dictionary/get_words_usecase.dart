import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class GetWordsUseCase {
  final DictionaryRepository repository;

  GetWordsUseCase(this.repository);

  Future<List<DictionaryWordModel>> execute() async {
    return await repository.getWords();
  }
}