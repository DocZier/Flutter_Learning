
import 'package:test_practic/features/auth/domain/entities/user_entity.dart';

class ProfileLocalDataSource {
  static final Map<String, dynamic> _storage = <String, dynamic>{};

  UserEntity getProfile() {
    return UserEntity(
      id: _storage['id'] as int,
      login: _storage['login'] as String,
      email: _storage['email'] as String,
      createdAt: DateTime.parse(_storage['created_at'] as String),
    );
  }

  void saveProfile(UserEntity user) {
   _storage['id'] = user.id;
   _storage['login'] = user.login;
   _storage['email'] = user.email;
   _storage['created_at'] = user.createdAt.toIso8601String();
  }

  void clearProfile() {
    _storage.clear();
  }
}
