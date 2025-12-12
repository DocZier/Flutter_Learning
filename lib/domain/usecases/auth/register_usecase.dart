import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/repositories/auth/auth_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/auth/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserModel?> execute(String login, String email, String password) async {
    return await repository.register(login, email, password);
  }
}