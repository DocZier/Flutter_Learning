import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/dictionary_model.dart';
import '../../data/repositories/dictionary_repository.dart';
import '../states/word_state.dart';

part 'word_provider.g.dart';

@riverpod
class Word extends _$Word {
  late final DictionaryRepository _repo;

  @override
  Future<WordState> build(int wordId) async {
    _repo = GetIt.I<DictionaryRepository>();

    final entity = await _repo.getWordById(wordId);
    return WordState(word: DictionaryWord.fromEntity(entity));
  }
}
