import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetKanjiExamplesUseCase {
  final DictionaryRepository repository;

  GetKanjiExamplesUseCase(this.repository);

  Future<List<KanjiWordExampleModel>> execute(String kanji) async {
    return await repository.getWordExamples(kanji);
  }
}