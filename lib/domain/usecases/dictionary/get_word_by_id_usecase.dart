import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetWordByIdUseCase {
  final DictionaryRepository repository;

  GetWordByIdUseCase(this.repository);

  Future<DictionaryWordModel> execute(String word) async {
    return await repository.getWordByWord(word);
  }
}