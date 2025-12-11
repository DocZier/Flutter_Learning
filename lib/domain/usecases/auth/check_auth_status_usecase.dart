

import 'package:test_practic/core/models/shared/user_entity.dart';
import 'package:test_practic/data/repositories/auth/auth_repository.dart';

class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  UserEntity? execute() {
    return repository.checkAuthStatus();
  }
}