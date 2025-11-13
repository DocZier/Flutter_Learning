import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/decks.dart';
import 'package:test_practic/provider/app_data_provider.dart';

part 'deck_id_provider.g.dart';

@riverpod
Deck deckById(Ref ref, {required String id}) {
  final data = ref.watch(appDataProvider);
  return data.decks.firstWhere((deck) => deck.id == id);
}
