import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';


class SearchKanjiUseCase {
  final DictionaryRepository repository;

  SearchKanjiUseCase(this.repository);

  Future<List<KanjiReadingModel>> execute(String query) async {
    if (query.length == 1 && _isKanjiCharacter(query)) {
      try {
        final kanji = await repository.searchKanjiByCharacter(query);
        return [kanji];
      } catch (e) {
        return [];
      }
    }
    return await repository.searchKanjiByReading(query);
  }

  bool _isKanjiCharacter(String char) {
    final code = char.codeUnitAt(0);
    return (code >= 0x4E00 && code <= 0x9FFF) ||
        (code >= 0x3400 && code <= 0x4DBF);
  }
}