import 'package:test_practic/data/repositories/auth/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> execute(int userId) async {
    repository.deleteAccount(userId);
  }
}