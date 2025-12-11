import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/features/dictionary/data/repositories/dictionary_repository.dart';

import '../../data/model/dictionary_model.dart';
import '../states/dictionary_state.dart';

part 'dictionary_provider.g.dart';

@riverpod
class Dictionary extends _$Dictionary {
  late final  DictionaryRepository _repo;
  late final TextEditingController searchController;

  @override
  Future<DictionaryState> build() async {
    _repo = GetIt.I<DictionaryRepository>();
    searchController = TextEditingController();
    ref.onDispose(() {
     searchController.dispose();
    });

    final remoteWords = await _repo.getWords();
    final words = remoteWords.map(DictionaryWord.fromEntity).toList();

    final history = _repo.getHistory();

    return DictionaryState(
      words: words,
      history: history,
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    final resultEntities = await _repo.search(query);
    final resultModels = resultEntities.map(DictionaryWord.fromEntity).toList();

    state = AsyncData(
      state.value!.copyWith(words: resultModels),
    );
  }

  Future<void> saveHistory(String query) async {
    _repo.saveHistory(query);

    final updated = _repo.getHistory();

    state = AsyncData(
      state.value!.copyWith(history: updated),
    );
  }

  Future<void> clearHistory() async {
    _repo.clearHistory();

    state = AsyncData(
      state.value!.copyWith(history: []),
    );
  }

  Future<DictionaryWord> getWordById(int id) async {
    final entity = await _repo.getWordById(id);
    return DictionaryWord.fromEntity(entity);
  }

  void saveWord(int id) {
    _repo.saveWord(id);
  }

  Future<void> deleteWord(int id) async {
    _repo.deleteWord(id);
  }
}