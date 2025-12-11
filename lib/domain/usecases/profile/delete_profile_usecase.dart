import 'package:test_practic/data/repositories/profile/profile_repository.dart';

class DeleteProfileUseCase {
  final ProfileRepository repository;

  DeleteProfileUseCase(this.repository);

  Future<void> execute(int userId) async {
    await repository.deleteProfile(userId);
  }
}
