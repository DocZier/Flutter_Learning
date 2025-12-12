import 'package:test_practic/data/repositories/auth/auth_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/auth/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  void execute() {
    repository.logout();
  }
}