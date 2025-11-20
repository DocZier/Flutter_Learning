import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../provider/app_data_provider.dart';
import '../../../services/auth_service.dart';
import '../../../state/data_container.dart';

part 'register_provider.g.dart';

@riverpod
class RegistrationForm extends _$RegistrationForm {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void build() {
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();

    ref.onDispose(() {
      username.dispose();
      email.dispose();
      password.dispose();
      confirmPassword.dispose();
    });
  }

  bool register() {
    final authService = GetIt.I<AuthService>();
    final user = authService.registerUser(UserData(email: email.text, password: password.text,username: username.text, decks: []));

    if (user != null) {
      ref.read(appDataProvider.notifier).setUser(user);
      return true;
    }
    return false;
  }

  bool validateAndRegister() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    return register();
  }
}