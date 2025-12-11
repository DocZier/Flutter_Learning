import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/dictionary/get_word_by_id_usecase.dart';
import '../../../../core/models/dictionary/dictionary_model.dart';
import '../states/word_state.dart';

part 'word_provider.g.dart';

@riverpod
class Word extends _$Word {
  late final GetWordByIdUseCase _getWordByIdUseCase;

  @override
  Future<WordState> build(int wordId) async {
    _getWordByIdUseCase = GetIt.I<GetWordByIdUseCase>();
    final entity = await _getWordByIdUseCase.execute(wordId);
    return WordState(word: DictionaryWord.fromEntity(entity));
  }
}
