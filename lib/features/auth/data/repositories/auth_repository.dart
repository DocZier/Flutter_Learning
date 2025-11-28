import '../../domain/entities/user_entity.dart';
import '../sources/local/auth_local_source.dart';
import '../sources/remote/auth_remote_source.dart';

abstract class AuthRepository {
  Future<UserEntity?> login(String login, String password);
  Future<UserEntity?> register(String login, String email, String password);
  void logout();
  UserEntity? checkAuthStatus();
  void deleteAccount(int userId);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<UserEntity?> login(String login, String password) async {
    try {
      final user = await _remoteDataSource.login(login, password);
      if (user != null) {
        _localDataSource.saveCurrentUser(user);
      }
      return user;
    } catch (e) {
      throw Exception('Ошибка входа: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> register(
      String login,
      String email,
      String password,
      ) async {
    try {
      final user = await _remoteDataSource.register(
        login: login,
        email: email,
        password: password,
      );
      _localDataSource.saveCurrentUser(user);
      return user;
    } catch (e) {
      throw Exception('Ошибка регистрации: ${e.toString()}');
    }
  }

  @override
  void logout() {
    _localDataSource.clearAuthData();
  }

  @override
  UserEntity? checkAuthStatus() {
    return _localDataSource.getCurrentUser();
  }

  @override
  void deleteAccount(int userId) async {
    await _remoteDataSource.deleteAccount(userId);
    _localDataSource.clearAuthData();
  }
}