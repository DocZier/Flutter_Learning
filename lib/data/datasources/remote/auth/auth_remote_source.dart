
import '../shared/remote_user_source.dart';
import '../../../../core/models/shared/user_entity.dart';

class AuthRemoteDataSource {

  final RemoteUserSource remote;

  AuthRemoteDataSource(this.remote);

  Future<UserEntity?> login(String login, String password) async {

    print('remote login attempt: ${login} ${password}');
    final user = remote.users.firstWhere(
          (u) => u['email'] == login && u['password'] == password,
      orElse: () => throw Exception('Данные неверны'),
    );

    return UserEntity(
      id: int.parse(user['id']),
      login: user['login'],
      email: user['email'],
      createdAt: DateTime.parse(user['created_at']),
    );
  }

  Future<UserEntity> register({
    required String login,
    required String password,
    String? email,
  }) async {

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

    return UserEntity(
      id: int.parse(newUser['id']!),
      login: newUser['login']!,
      email: newUser['email']!,
      createdAt: DateTime.parse(newUser['created_at']!),
    );
  }

  Future<void> deleteAccount(int userId) async {
    remote.users.removeWhere((u) => u['id'] == userId.toString());
  }
}