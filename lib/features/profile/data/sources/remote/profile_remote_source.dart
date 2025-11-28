
import 'package:test_practic/features/auth/domain/entities/user_entity.dart';

class ProfileRemoteDataSource {
  static final List<Map<String, dynamic>> _profiles = [
    {
      'id': 1,
      'login': 'test',
      'email': 'test@test.com',
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  Future<UserEntity?> getProfileById(int userId) async {
    try {
      print("Remote storage: ${_profiles.toString()}");
      final profile = _profiles.firstWhere((p) => p['id'] == userId);
      print("Remote profile: ${profile.toString()} to ${userId.toString()}");
      return UserEntity(
       id: profile['id'],
       login: profile['login'],
       email: profile['email'],
       createdAt: DateTime.parse(profile['created_at']),
      );
    } catch (e) {
      print("Remote error: $e");
      return null;
    }
  }

  Future<bool> addProfile(String login, int userId, String email) async {
    try {
      _profiles.add({
        'id': (_profiles.length + 1),
        'login': login,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteProfile(int userId) async {
    _profiles.removeWhere((p) => p['id'] == userId);
  }

  Future<void> saveProfile(UserEntity user, int userId) async {
    final index = _profiles.indexWhere((p) => p['id'] == userId);
    print("Remote index: $index");

    if (index == -1) {
      _profiles.add({
        'id': (_profiles.length + 1),
        'login': user.login,
        'email': user.email,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      _profiles[index] = {
        'id': _profiles[index]['id'],
        'login': user.login,
        'email': user.email,
        'created_at': _profiles[index]['created_at'],
      };
    }
  }
}