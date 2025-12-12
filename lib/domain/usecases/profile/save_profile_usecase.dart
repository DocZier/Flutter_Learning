import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/repositories/profile/profile_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/profile/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> execute(UserModel profile, int userId) async {
    await repository.saveProfile(profile, userId);
  }
}