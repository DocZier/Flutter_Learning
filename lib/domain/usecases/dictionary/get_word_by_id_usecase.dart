import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetWordByIdUseCase {
  final DictionaryRepository repository;

  GetWordByIdUseCase(this.repository);

  Future<DictionaryWordModel> execute(int id) async {
    return await repository.getWordById(id);
  }
}