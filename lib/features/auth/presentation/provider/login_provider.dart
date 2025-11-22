import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/data/user_model.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/state/auth_state.dart';
import '../../data/repositories/auth_repository.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {

  late final AuthRepository _repository;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController email;
  late final TextEditingController password;


  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  @override
  void build() {
    _repository = GetIt.I<AuthRepository>();

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

      final user = await _repository.login(
          email.text.trim(),
          password.text.trim()
      );

      if (user != null) {
        ref
            .read(authProvider.notifier)
            .updateState(Authenticated(user: User.fromEntity(user)));

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
