import '../../../domain/entities/user_entity.dart';

class AuthLocalDataSource {
  static const _currentUserKey = 'current_user';

  static final Map<String, dynamic> _storage = <String, dynamic>{};

  void saveCurrentUser(UserEntity user) {
    _storage[_currentUserKey] = {
      'id': user.id,
      'email': user.email,
      'name': user.login,
      'created_at': user.createdAt.toIso8601String(),
    };
  }

  UserEntity? getCurrentUser() {
    final userData = _storage[_currentUserKey];
    if (userData != null) {
      return UserEntity(
        id: userData['id'],
        email: userData['email'],
        login: userData['name'],
        createdAt: DateTime.parse(userData['created_at']),
      );
    }
    return null;
  }

  void clearAuthData() {
    _storage.remove(_currentUserKey);
  }
}