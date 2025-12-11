import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/dictionary/clear_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_word_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_words_usecase.dart';

import '../../../../core/models/dictionary/dictionary_model.dart';
import '../states/dictionary_state.dart';

part 'dictionary_provider.g.dart';

@riverpod
class Dictionary extends _$Dictionary {
  late final GetWordsUseCase _getWordsUseCase;
  late final GetHistoryUseCase _getHistoryUseCase;
  late final SaveHistoryUseCase _saveHistoryUseCase;
  late final ClearHistoryUseCase _clearHistoryUseCase;
  late final SearchWordsUseCase _searchWordsUseCase;
  late final GetWordByIdUseCase _getWordByIdUseCase;

  late final TextEditingController searchController;

  @override
  Future<DictionaryState> build() async {
    _getWordsUseCase = GetIt.I<GetWordsUseCase>();
    _getHistoryUseCase = GetIt.I<GetHistoryUseCase>();
    _saveHistoryUseCase = GetIt.I<SaveHistoryUseCase>();
    _clearHistoryUseCase = GetIt.I<ClearHistoryUseCase>();
    _searchWordsUseCase = GetIt.I<SearchWordsUseCase>();
    _getWordByIdUseCase = GetIt.I<GetWordByIdUseCase>();

    searchController = TextEditingController();
    ref.onDispose(() {
      searchController.dispose();
    });

    final remoteWords = await _getWordsUseCase.execute();
    final words = remoteWords.map(DictionaryWord.fromEntity).toList();
    final history = _getHistoryUseCase.execute();

    return DictionaryState(
      words: words,
      history: history,
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    final resultEntities = await _searchWordsUseCase.execute(query);
    final resultModels = resultEntities.map(DictionaryWord.fromEntity).toList();
    state = AsyncData(
      state.value!.copyWith(words: resultModels),
    );
  }

  Future<void> saveHistory(String query) async {
    _saveHistoryUseCase.execute(query);
    final updated = _getHistoryUseCase.execute();
    state = AsyncData(
      state.value!.copyWith(history: updated),
    );
  }

  Future<void> clearHistory() async {
    _clearHistoryUseCase.execute();
    state = AsyncData(
      state.value!.copyWith(history: []),
    );
  }

  Future<DictionaryWord> getWordById(int id) async {
    final entity = await _getWordByIdUseCase.execute(id);
    return DictionaryWord.fromEntity(entity);
  }
}