import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/core/models/dictionary/kanji_model.dart';
import 'package:test_practic/data/datasources/remote/kanji_remote_source.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';

import '../../datasources/local/dictionary_local_source.dart';
import '../../datasources/remote/dictionary_remote_source.dart';

class DictionaryRepositoryImpl implements DictionaryRepository {
  final DictionaryLocalDataSource _localDataSource;
  final DictionaryRemoteDataSource _remoteDataSource;
  final KanjiRemoteDataSource _kanjiRemoteDataSource;

  DictionaryRepositoryImpl({
    required DictionaryLocalDataSource localDataSource,
    required DictionaryRemoteDataSource remoteDataSource,
    required KanjiRemoteDataSource kanjiRemoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _kanjiRemoteDataSource = kanjiRemoteDataSource;

  @override
  Future<List<DictionaryWordModel>> getWords() async {
    return _remoteDataSource.getWords();
  }

  @override
  Future<DictionaryWordModel> getWordByWord(String word) async {
    return _remoteDataSource.getWordByWord(word);
  }

  @override
  Future<List<DictionaryWordModel>> getSavedWords() async {
    return _localDataSource.getWords();
  }

  @override
  Future<void> saveWord(String word) async {
    final wordModel = await _remoteDataSource.getWordByWord(word);
    await _localDataSource.saveWord(wordModel);
  }


  @override
  Future<List<DictionaryWordModel>> search(String query) async {
    return _remoteDataSource.search(query);
  }

  @override
  Future<void> deleteWord(String word) async {
    await _localDataSource.deleteWord(word);
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

  @override
  Future<KanjiDetailModel> getKanjiDetails(String kanji) async {
    return _kanjiRemoteDataSource.getKanjiDetails(kanji);
  }

  @override
  Future<List<KanjiReadingModel>> searchKanjiByReading(String reading) async {
    return _kanjiRemoteDataSource.searchKanjiByReading(reading);
  }

  @override
  Future<List<KanjiWordExampleModel>> getWordExamples(String kanji) async {
    return _kanjiRemoteDataSource.getWordExamples(kanji);
  }

  @override
  Future<KanjiReadingModel> searchKanjiByCharacter(String character) async {
    return _kanjiRemoteDataSource.searchKanjiByCharacter(character);
  }
}