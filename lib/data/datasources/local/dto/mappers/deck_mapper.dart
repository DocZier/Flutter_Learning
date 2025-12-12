import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';
import 'package:test_practic/data/datasources/local/database/tables/deck_table.dart';

extension DeckLocalMapper on Deck {
  DeckModel toModel() {
    return DeckModel(
      userId: userId,
      id: id,
      title: title,
      description: description,
    );
  }
}

extension DeckModelLocalMapper on DeckModel {
  Deck toLocalDto() {
    return Deck(
      userId: userId,
      id: id,
      title: title,
      description: description,
    );
  }
}