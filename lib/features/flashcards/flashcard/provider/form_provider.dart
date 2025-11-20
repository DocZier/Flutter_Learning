import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

@riverpod
class AddCardForm extends _$AddCardForm {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController question;
  late final TextEditingController answer;

  @override
  void build() {
    formKey = GlobalKey<FormState>();
    question = TextEditingController();
    answer = TextEditingController();

    ref.onDispose(() {
      question.dispose();
      answer.dispose();
    });
  }
}