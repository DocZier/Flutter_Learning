import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_practic/core/models/shared/user_model.dart';

class AuthLocalDataSource {
  static const _currentUserKey = 'current_user';
  final _storage = const FlutterSecureStorage();

  Future<void> saveCurrentUser(UserModel user) async {
    await _storage.write(
      key: _currentUserKey,
      value: json.encode({
        'id': user.id,
        'email': user.email,
        'login': user.login,
        'created_at': user.createdAt.toIso8601String(),
      }),
    );
  }

  Future<UserModel?> getCurrentUser() async {
    final userDataString = await _storage.read(key: _currentUserKey);
    if (userDataString == null) return null;

    final userData = json.decode(userDataString);
    return UserModel(
      id: userData['id'],
      email: userData['email'],
      login: userData['login'],
      createdAt: DateTime.parse(userData['created_at']),
    );
  }

  Future<void> clearAuthData() async {
    await _storage.delete(key: _currentUserKey);
  }
}