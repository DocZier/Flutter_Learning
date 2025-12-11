
import 'package:test_practic/features/auth/domain/entities/user_entity.dart';

import '../../../../../shared/data/remote_user_source.dart';

class ProfileRemoteDataSource {
  final RemoteUserSource remote;

  ProfileRemoteDataSource(this.remote);

  Future<UserEntity?> getProfileById(int userId) async {
    try {
      print("Remote storage: ${remote.users.toString()}");
      final profile = remote.users.firstWhere((p) => p['id'] == '$userId');
      print("Remote profile: ${profile.toString()} to ${userId.toString()}");
      return UserEntity(
       id: int.parse(profile['id']),
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
      remote.users.add({
        'id': '${remote.users.length + 1}',
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
    remote.users.removeWhere((p) => p['id'] == '$userId');
  }

  Future<void> saveProfile(UserEntity user, int userId) async {
    final index = remote.users.indexWhere((p) => p['id'] == '$userId');
    print("Remote index: $index");

    if (index == -1) {
      remote.users.add({
        'id': '${remote.users.length + 1}',
        'login': user.login,
        'email': user.email,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      remote.users[index] = {
        'id': '${remote.users[index]['id']}',
        'login': user.login,
        'email': user.email,
        'created_at': remote.users[index]['created_at'],
      };
    }
  }
}