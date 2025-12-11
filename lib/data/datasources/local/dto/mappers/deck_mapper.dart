import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/local/dto/deck_dto.dart';

extension DeckLocalMapper on DeckLocalDto {
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
  DeckLocalDto toLocalDto() {
    return DeckLocalDto(
      userId: userId,
      id: id,
      title: title,
      description: description,
    );
  }
}