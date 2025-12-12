import 'package:test_practic/core/models/shared/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login(String login, String password);
  Future<UserModel?> register(String login, String email, String password);
  void logout();
  UserModel? checkAuthStatus();
  void deleteAccount(int userId);
}