import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../provider/app_data_provider.dart';
import '../../../services/auth_service.dart';

part 'login_provider.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void build() {
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();

    ref.onDispose(() {
      email.dispose();
      password.dispose();
    });
  }

  bool login() {
    final authService = GetIt.I<AuthService>();
    final user =  authService.loginUser(email.text, password.text);
    if (user != null) {
      ref.read(appDataProvider.notifier).setUser(user);
      return true;
    }
    return false;
  }

  bool validateAndLogin() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    return login();
  }
}
