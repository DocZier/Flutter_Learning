import 'package:test_practic/core/models/dictionary/kanji_model.dart';

class KanjiState {
  final KanjiDetailModel kanji;
  final List<KanjiWordExampleModel> examples;

  KanjiState({
    required this.kanji,
    required this.examples,
  });

  KanjiState copyWith({
    KanjiDetailModel? kanji,
    List<KanjiWordExampleModel>? examples,
  }) {
    return KanjiState(
      kanji: kanji ?? this.kanji,
      examples: examples ?? this.examples,
    );
  }
}