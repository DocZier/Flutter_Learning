import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/repositories/auth/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  UserModel? execute() {
    return repository.checkAuthStatus();
  }
}