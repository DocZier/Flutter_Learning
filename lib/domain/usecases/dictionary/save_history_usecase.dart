import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class SaveHistoryUseCase {
  final DictionaryRepository repository;

  SaveHistoryUseCase(this.repository);

  void execute(String query) {
    repository.saveHistory(query);
  }
}