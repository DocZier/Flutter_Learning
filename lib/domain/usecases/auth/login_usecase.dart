import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/repositories/auth/auth_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel?> execute(String login, String password) async {
    print('start usecase');
    return await repository.login(login, password);
  }
}