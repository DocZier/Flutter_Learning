import 'package:test_practic/core/models/shared/user_model.dart';

class ProfileLocalDataSource {
  static final Map<String, dynamic> _storage = <String, dynamic>{};

  UserModel getProfile() {
    return UserModel(
      id: _storage['id'] as int,
      login: _storage['login'] as String,
      email: _storage['email'] as String,
      createdAt: DateTime.parse(_storage['created_at'] as String),
    );
  }

  void saveProfile(UserModel user) {
    _storage['id'] = user.id;
    _storage['login'] = user.login;
    _storage['email'] = user.email;
    _storage['created_at'] = user.createdAt.toIso8601String();
  }

  void clearProfile() {
    _storage.clear();
  }
}