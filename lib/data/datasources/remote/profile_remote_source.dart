
import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/profile_mapper.dart';
import 'package:test_practic/data/datasources/remote/dto/profile_dto.dart';
import 'package:test_practic/data/datasources/remote/user_remote_source.dart';

class ProfileRemoteDataSource {
  final RemoteUserSource remote;

  ProfileRemoteDataSource(this.remote);

  Future<UserModel?> getProfileById(int userId) async {
    try {
      final profile = remote.users.firstWhere((p) => p['id'] == '$userId');
      return ProfileDto.fromJson(profile).toModel();
    } catch (e) {
      return null;
    }
  }

  Future<bool> addProfile(String login, int userId, String email) async {
    try {
      remote.users.add({
        'id': '${remote.users.length + 1}',
        'login': login,
        'email': email,
        'password': '', // Пустой пароль для профиля
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

  Future<void> saveProfile(UserModel user, int userId) async {
    final index = remote.users.indexWhere((p) => p['id'] == '$userId');
    if (index == -1) {
      remote.users.add({
        'id': '${remote.users.length + 1}',
        'login': user.login,
        'email': user.email,
        'password': '', // Пустой пароль для профиля
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      remote.users[index] = {
        'id': '${remote.users[index]['id']}',
        'login': user.login,
        'email': user.email,
        'password': remote.users[index]['password'],
        'created_at': remote.users[index]['created_at'],
      };
    }
  }
}