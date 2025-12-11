import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class ClearHistoryUseCase {
  final DictionaryRepository repository;

  ClearHistoryUseCase(this.repository);

  void execute() {
    repository.clearHistory();
  }
}