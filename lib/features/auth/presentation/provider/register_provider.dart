import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/data/user_model.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/state/auth_state.dart';
import '../../data/repositories/auth_repository.dart';

part 'register_provider.g.dart';

@riverpod
class Registration extends _$Registration {
  late final AuthRepository _repository;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void build() {
    _repository = GetIt.I<AuthRepository>();

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

  Future<void> register({
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final user = await _repository.register(
        email.text.trim(),
        password.text.trim(),
        username.text.trim(),
      );
      if (user != null) {
        ref
            .read(authProvider.notifier)
            .updateState(Authenticated(user: User.fromEntity(user)));
        onSuccess();
      } else {
        onError('Ошибка регистрации');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}