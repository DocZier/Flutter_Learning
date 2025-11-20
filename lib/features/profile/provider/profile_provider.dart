import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/state/data_container.dart';

import '../../../provider/app_data_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {

  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;
  late final TextEditingController password;

  @override
  UserData build() {
    final user = ref.watch(appDataProvider.notifier).getUser();

    username = TextEditingController(text: user.username);
    password = TextEditingController(text: user.password);
    formKey = GlobalKey<FormState>();

    ref.onDispose(() {
      username.dispose();
      password.dispose();
    });

    return user;
  }


  void logout() {
    ref.read(appDataProvider.notifier).logout();
  }

  bool updateProfile() {
    String? newUsername;
    String? newPassword;

    if (username.text.trim().isNotEmpty && username.text.trim() != ref.read(appDataProvider.notifier).getUser().username) {
      newUsername = username.text.trim();
    }

    if (password.text.trim().isNotEmpty &&
        password.text.trim() != ref.read(appDataProvider.notifier).getUser().password) {
      newPassword = password.text.trim();
    }

    if (newUsername == null && newPassword == null) {
      return true;
    }

    final isUpdated = ref.read(appDataProvider.notifier).updateUserFields(
      username: newUsername,
      password: newPassword,
    );

    return isUpdated;
  }

  bool deleteUser() {
    return ref.read(appDataProvider.notifier).deleteUser();
  }

  bool resetUser() {
    return ref.read(appDataProvider.notifier).resetUser();
  }
}