import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/core/models/dictionary/dictionary_model.dart';
import 'package:test_practic/domain/usecases/dictionary/get_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/clear_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_kanji_usecase.dart';
import 'package:test_practic/presentation/features/dictionary/states/search_state.dart';

part 'search_provider.g.dart';

@riverpod
class DictionarySearch extends _$DictionarySearch {
  late final GetHistoryUseCase _getHistoryUseCase;
  late final SaveHistoryUseCase _saveHistoryUseCase;
  late final ClearHistoryUseCase _clearHistoryUseCase;
  late final SearchWordsUseCase _searchWordsUseCase;
  late final SearchKanjiUseCase _searchKanjiUseCase;

  late final TextEditingController searchController;
  SearchMode _searchMode = SearchMode.words;

  SearchMode get searchMode => _searchMode;

  @override
  Future<SearchState> build() async {
    _getHistoryUseCase = GetIt.I<GetHistoryUseCase>();
    _saveHistoryUseCase = GetIt.I<SaveHistoryUseCase>();
    _clearHistoryUseCase = GetIt.I<ClearHistoryUseCase>();
    _searchWordsUseCase = GetIt.I<SearchWordsUseCase>();
    _searchKanjiUseCase = GetIt.I<SearchKanjiUseCase>();

    searchController = TextEditingController();
    ref.onDispose(() {
      searchController.dispose();
    });

    final randomWords = await _searchWordsUseCase.execute('');

    return SearchState(
      words: randomWords,
      kanji: [],
      history: _getHistoryUseCase.execute(),
      searchMode: SearchMode.words,
    );
  }

  void setSearchMode(SearchMode mode) {
    _searchMode = mode;
    state = AsyncData(state.value!.copyWith(searchMode: mode));
  }

  Future<void> search(String query, {bool submit = false}) async {
    if (query.trim().isEmpty && !submit) {
      if (_searchMode == SearchMode.words) {
        final randomWords = await _searchWordsUseCase.execute('');
        state = AsyncData(state.value!.copyWith(words: randomWords));
      }
      return;
    }

    if (_searchMode == SearchMode.words) {
      final result = await _searchWordsUseCase.execute(query.trim());
      state = AsyncData(state.value!.copyWith(words: result.toList()));

      if (submit && query.trim().isNotEmpty) {
        _saveHistory(query.trim());
      }
    } else {
      final result = await _searchKanjiUseCase.execute(query.trim());
      state = AsyncData(state.value!.copyWith(kanji: result));

      if (submit && query.trim().isNotEmpty) {
        _saveHistory(query.trim());
      }
    }
  }

  Future<void> clearHistory() async {
    _clearHistoryUseCase.execute();
    state = AsyncData(state.value!.copyWith(history: []));
  }

  void _saveHistory(String query) {
    _saveHistoryUseCase.execute(query);
    final updatedHistory = _getHistoryUseCase.execute();
    state = AsyncData(state.value!.copyWith(history: updatedHistory));
  }
}