import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {

  late final GlobalKey<FormState> formKey;
  late final TextEditingController username;
  late final TextEditingController password;

  void build() {
    username = TextEditingController();
    password = TextEditingController();
    formKey = GlobalKey<FormState>();

    ref.onDispose(() {
      username.dispose();
      password.dispose();
    });

  }


  void logout() {

  }

  bool updateProfile() {
    String? newUsername;
    String? newPassword;

       return true;
  }

  bool deleteUser() {
    return true;
  }

  bool resetUser() {
    return true;
  }
}