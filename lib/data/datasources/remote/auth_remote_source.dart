import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/user_mapper.dart';

import 'dto/user_dto.dart';
import 'user_remote_source.dart';

class AuthRemoteDataSource {
  final RemoteUserSource remote;

  AuthRemoteDataSource(this.remote);

  Future<UserModel?> login(String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = remote.users.firstWhere(
            (u) => u['email'] == login && u['password'] == password,
      );
      return UserDto.fromJson(user).toModel();
    } catch (e) {
      throw Exception('Данные неверны');
    }
  }

  Future<UserModel> register({
    required String login,
    required String password,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (remote.users.any((u) => u['email'] == email)) {
      throw Exception('Пользователь уже существует');
    }
    if (remote.users.any((u) => u['login'] == login)) {
      throw Exception('Имя уже используется');
    }
    final Map<String, String> newUser = {
      'id': '${remote.users.length + 1}',
      'login': login,
      'email': email.toString(),
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
    };
    remote.users.add(newUser);
    return UserDto.fromJson(newUser).toModel();
  }

  Future<void> deleteAccount(int userId) async {
    remote.users.removeWhere((u) => u['id'] == userId.toString());
  }
}