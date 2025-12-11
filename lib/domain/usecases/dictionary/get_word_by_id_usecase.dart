import 'package:test_practic/core/models/dictionary/dictionary_entity.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class GetWordByIdUseCase {
  final DictionaryRepository repository;

  GetWordByIdUseCase(this.repository);

  Future<DictionaryWordEntity> execute(int id) async {
    return await repository.getWordById(id);
  }
}