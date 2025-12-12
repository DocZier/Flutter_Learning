
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class SearchKanjiByCharacterUseCase {
  final DictionaryRepository repository;

  SearchKanjiByCharacterUseCase(this.repository);

  Future<KanjiReadingModel> execute(String character) async {
    return await repository.searchKanjiByCharacter(character);
  }
}