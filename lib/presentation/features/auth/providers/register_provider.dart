import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/auth/register_usecase.dart';
import '../../../../core/models/shared/user_model.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';

part 'register_provider.g.dart';

@riverpod
class Registration extends _$Registration {
  late final RegisterUseCase _useCase;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void build() {
    _useCase = GetIt.I<RegisterUseCase>();
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
      final user = await _useCase.execute(
        username.text.trim(),
        email.text.trim(),
        password.text.trim(),
      );
      if (user != null) {
        ref
            .read(authProvider.notifier)
            .updateState(Authenticated(user: user));
        onSuccess();
      } else {
        onError('Ошибка регистрации');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}