import 'package:test_practic/models/decks.dart';

class AppData {
  final List<Deck> decks;

  const AppData({required this.decks});

  AppData copyWith({List<Deck>? decks}) =>
      AppData(decks: decks ?? this.decks);
}

