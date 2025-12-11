import 'package:test_practic/data/repositories/dictionary/dictionary_repository.dart';

class GetHistoryUseCase {
  final DictionaryRepository repository;

  GetHistoryUseCase(this.repository);

  List<String> execute() {
    return repository.getHistory();
  }
}
