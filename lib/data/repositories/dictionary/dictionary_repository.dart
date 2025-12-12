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
    return await _remoteDataSource.getWords();
  }

  @override
  Future<DictionaryWordModel> getWordById(int id) async {
    return await _remoteDataSource.getWordById(id);
  }

  @override
  Future<List<DictionaryWordModel>> getSavedWords() async {
    return await _localDataSource.getWords();
  }

  @override
  Future<void> saveWord(int id) async {
    final word = await _remoteDataSource.getWordById(id);
    await _localDataSource.saveWord(word);
  }

  @override
  Future<List<DictionaryWordModel>> search(String query) async {
    return _remoteDataSource.search(query);
  }

  @override
  Future<void> deleteWord(int id) async {
    await _localDataSource.deleteWord(id);
  }

  @override
  Future<void> clear() async {
    await _localDataSource.clear();
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
