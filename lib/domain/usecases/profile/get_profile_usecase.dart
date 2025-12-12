import 'package:test_practic/core/models/shared/user_model.dart';
import 'package:test_practic/data/repositories/profile/profile_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/profile/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserModel> execute(int userId) async {
    return await repository.getProfile(userId);
  }
}