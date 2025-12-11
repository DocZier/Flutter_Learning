import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/datasources/remote/dto/test_dto.dart';

extension TestRemoteMapper on TestRemoteDto {
  TestModel toModel() {
    return TestModel(
      id: id,
      lessonId: lessonId,
      question: question,
      options: options,
      correctOptionIndex: correctOptionIndex,
      shortTheory: shortTheory,
      translation: translation,
      nextReviewDate: null,
    );
  }
}

extension TestModelRemoteMapper on TestModel {
  TestRemoteDto toRemoteDto() {
    return TestRemoteDto(
      id: id,
      lessonId: lessonId,
      question: question,
      options: options,
      correctOptionIndex: correctOptionIndex,
      shortTheory: shortTheory,
      translation: translation,
    );
  }
}