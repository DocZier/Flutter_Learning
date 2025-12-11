import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_flashcard_usecase.dart';

part 'add_card_provider.g.dart';

@riverpod
class AddCardNotifier extends _$AddCardNotifier {
  late SaveFlashcardUseCase _saveFlashcardUseCase;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController question;
  late final TextEditingController answer;

  @override
  void build() {
    _saveFlashcardUseCase = GetIt.I<SaveFlashcardUseCase>();
    formKey = GlobalKey<FormState>();
    question = TextEditingController();
    answer = TextEditingController();
    ref.onDispose(() {
      question.dispose();
      answer.dispose();
    });
  }

  Future<void> addCard(String deckId, String questionText, String answerText) async {
    final flashcard = FlashcardModel(
      deckId: deckId,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: questionText,
      answer: answerText,
      interval: 1,
      easeFactor: 2.5,
      nextReview: DateTime.now(),
      reviewCount: 0,
      lastReviewedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await _saveFlashcardUseCase.execute(flashcard);
  }
}