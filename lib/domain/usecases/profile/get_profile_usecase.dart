import 'package:test_practic/core/models/shared/user_entity.dart';
import 'package:test_practic/data/repositories/profile/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserEntity> execute(int userId) async {
    return await repository.getProfile(userId);
  }
}