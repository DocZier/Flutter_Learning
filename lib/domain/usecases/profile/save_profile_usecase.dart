import 'package:test_practic/core/models/shared/user_entity.dart';
import 'package:test_practic/data/repositories/profile/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> execute(UserEntity profile, int userId) async {
    await repository.saveProfile(profile, userId);
  }
}