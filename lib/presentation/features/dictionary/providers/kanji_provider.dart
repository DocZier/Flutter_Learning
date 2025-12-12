import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/dictionary/get_kanji_details_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_kanji_examples_usecase.dart';
import 'package:test_practic/presentation/features/dictionary/states/kanji_state.dart';

part 'kanji_provider.g.dart';

@riverpod
class KanjiDetail extends _$KanjiDetail {
  late final GetKanjiDetailsUseCase _getKanjiDetailsUseCase;
  late final GetKanjiExamplesUseCase _getKanjiExamplesUseCase;

  @override
  Future<KanjiState> build(String kanji) async {
    _getKanjiDetailsUseCase = GetIt.I<GetKanjiDetailsUseCase>();
    _getKanjiExamplesUseCase = GetIt.I<GetKanjiExamplesUseCase>();

    final kanjiDetail = await _getKanjiDetailsUseCase.execute(kanji);
    final examples = await _getKanjiExamplesUseCase.execute(kanji);

    return KanjiState(
      kanji: kanjiDetail,
      examples: examples,
    );
  }
}