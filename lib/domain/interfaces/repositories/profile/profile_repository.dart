import 'package:test_practic/core/models/shared/user_model.dart';

abstract class ProfileRepository {
  Future<UserModel> getProfile(int userId);
  Future<void> saveProfile(UserModel profile, int userId);
  Future<void> deleteProfile(int userId);
  void logout();
}
