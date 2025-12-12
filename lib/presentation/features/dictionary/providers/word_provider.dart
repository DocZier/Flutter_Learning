import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/dictionary/get_word_by_id_usecase.dart';
import '../states/word_state.dart';

part 'word_provider.g.dart';

@riverpod
class Word extends _$Word {

  @override
  Future<WordState> build(String word) async {
    final model = await GetIt.I<GetWordByIdUseCase>().execute(word);
    print('${word}: ${model}');
    return WordState(word: model);
  }
}
