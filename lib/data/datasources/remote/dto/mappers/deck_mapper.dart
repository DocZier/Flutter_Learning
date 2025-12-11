import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/data/datasources/remote/dto/deck_dto.dart';

extension DeckRemoteMapper on DeckRemoteDto {
  DeckModel toModel() {
    return DeckModel(
      userId: userId,
      id: id,
      title: title,
      description: description,
    );
  }
}

extension DeckModelRemoteMapper on DeckModel {
  DeckRemoteDto toRemoteDto() {
    return DeckRemoteDto(
      userId: userId,
      id: id,
      title: title,
      description: description,
    );
  }
}