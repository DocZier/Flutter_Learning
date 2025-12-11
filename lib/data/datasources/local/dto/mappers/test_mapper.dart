import 'package:test_practic/core/models/lessons/test_model.dart';
import 'package:test_practic/data/datasources/local/dto/test_dto.dart';

extension TestLocalMapper on TestLocalDto {
  TestModel toModel() {
    return TestModel(
      id: id,
      lessonId: lessonId,
      question: question,
      options: options,
      correctOptionIndex: correctOptionIndex,
      shortTheory: shortTheory,
      translation: translation,
      nextReviewDate: nextReviewDate,
    );
  }
}

extension TestModelLocalMapper on TestModel {
  TestLocalDto toLocalDto() {
    return TestLocalDto(
      id: id,
      lessonId: lessonId,
      question: question,
      options: options,
      correctOptionIndex: correctOptionIndex,
      shortTheory: shortTheory,
      translation: translation,
      nextReviewDate: nextReviewDate,
    );
  }
}