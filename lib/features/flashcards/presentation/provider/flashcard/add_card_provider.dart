import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/features/flashcards/data/repositories/flashcard_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../data/model/flashcards_model.dart';

part 'add_card_provider.g.dart';

@riverpod
class AddCardNotifier extends _$AddCardNotifier {
  late FlashcardRepository _repo;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController question;
  late final TextEditingController answer;

  @override
  void build() {
    _repo = GetIt.I<FlashcardRepository>();
    formKey = GlobalKey<FormState>();
    question = TextEditingController();
    answer = TextEditingController();

    ref.onDispose(() {
      question.dispose();
      answer.dispose();
    });
  }

  Future<void> addCard(String deckId, Flashcard card) async {
    return await _repo.saveFlashcard(card.toEntity());
  }
}