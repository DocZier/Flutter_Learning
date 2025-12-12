import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/domain/interfaces/repositories/auth/auth_repository.dart';
import '../../datasources/local/auth_local_source.dart';
import '../../datasources/remote/auth_remote_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<UserModel?> login(String login, String password) async {
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
  Future<UserModel?> register(
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
  UserModel? checkAuthStatus() {
    return _localDataSource.getCurrentUser();
  }

  @override
  void deleteAccount(int userId) async {
    await _remoteDataSource.deleteAccount(userId);
    _localDataSource.clearAuthData();
  }
}