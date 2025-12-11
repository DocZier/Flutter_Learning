import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/domain/usecases/auth/login_usecase.dart';
import '../../../../core/models/shared/user_model.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  late final LoginUseCase _useCase;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController email;
  late final TextEditingController password;
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  @override
  void build() {
    _useCase = GetIt.I<LoginUseCase>();
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
    ref.onDispose(() {
      email.dispose();
      password.dispose();
    });
  }

  Future<void> login({
    required void Function(String error) onError,
    required void Function() onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      _isSubmitting = true;
      print('login attempt: ${email.text} ${password.text}');
      final user = await _useCase.execute(
        email.text.trim(),
        password.text.trim(),
      );
      print('user: ${user.toString()}');
      if (user != null) {
        ref
            .read(authProvider.notifier)
            .updateState(Authenticated(user: user));
        onSuccess();
      } else {
        onError('Login failed');
      }
      _isSubmitting = false;
    } catch (e) {
      onError(e.toString());
    }
  }
}
