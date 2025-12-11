import '../../../core/models/dictionary/dictionary_entity.dart';
import '../../datasources/local/dictionary/dictionary_local_source.dart';
import '../../datasources/remote/dictionary/dictionary_remote_source.dart';

abstract class DictionaryRepository {
  Future<List<DictionaryWordEntity>> getWords();
  Future<DictionaryWordEntity> getWordById(int id);
  List<DictionaryWordEntity> getSavedWords();
  Future<List<DictionaryWordEntity>> search(String query);
  void saveWord(int id);
  void deleteWord(int id);
  void clear();
  List<String> getHistory();
  void saveHistory(String query);
  void clearHistory();
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  final DictionaryLocalDataSource _localDataSource;
  final DictionaryRemoteDataSource _remoteDataSource;

  DictionaryRepositoryImpl({
    required DictionaryLocalDataSource localDataSource,
    required DictionaryRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<List<DictionaryWordEntity>> getWords() async {
    return _remoteDataSource.getWords();
  }

  @override
  Future<DictionaryWordEntity> getWordById(int id) async {
    return _remoteDataSource.getWordById(id);
  }

  @override
  List<DictionaryWordEntity> getSavedWords() {
    return _localDataSource.getWords();
  }

  @override
  void saveWord(int id) async {
    final word = await _remoteDataSource.getWordById(id);
    _localDataSource.saveWord(word);
  }

  @override
  Future<List<DictionaryWordEntity>> search(String query) async {
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
