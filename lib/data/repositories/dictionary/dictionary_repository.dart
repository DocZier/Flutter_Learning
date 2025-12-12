import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

import '../../datasources/local/dictionary_local_source.dart';
import '../../datasources/remote/dictionary_remote_source.dart';

class DictionaryRepositoryImpl implements DictionaryRepository {
  final DictionaryLocalDataSource _localDataSource;
  final DictionaryRemoteDataSource _remoteDataSource;

  DictionaryRepositoryImpl({
    required DictionaryLocalDataSource localDataSource,
    required DictionaryRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<List<DictionaryWordModel>> getWords() async {
    return _remoteDataSource.getWords();
  }

  @override
  Future<DictionaryWordModel> getWordById(int id) async {
    return _remoteDataSource.getWordById(id);
  }

  @override
  List<DictionaryWordModel> getSavedWords() {
    return _localDataSource.getWords();
  }

  @override
  void saveWord(int id) async {
    final word = await _remoteDataSource.getWordById(id);
    _localDataSource.saveWord(word);
  }

  @override
  Future<List<DictionaryWordModel>> search(String query) async {
    return _remoteDataSource.search(query);
  }

  @override
  void deleteWord(int id) {
    _localDataSource.deleteWord(id);
  }

  @override
  void clear() {
    _localDataSource.clear();
  }

  @override
  List<String> getHistory() {
    return _localDataSource.getHistory();
  }

  @override
  void saveHistory(String query) {
    _localDataSource.saveHistory(query);
  }

  @override
  void clearHistory() {
    _localDataSource.clearHistory();
  }
}
