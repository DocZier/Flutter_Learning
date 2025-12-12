import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

class GetKanjiDetailsUseCase {
  final DictionaryRepository repository;

  GetKanjiDetailsUseCase(this.repository);

  Future<KanjiDetailModel> execute(String kanji) async {
    return await repository.getKanjiDetails(kanji);
  }
}