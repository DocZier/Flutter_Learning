
import 'package:test_practic/core/models/shared/user_entity.dart';

import '../../datasources/local/profile/profile_local_source.dart';
import '../../datasources/remote/profile/profile_remote_source.dart';

abstract class ProfileRepository {
  Future<UserEntity> getProfile(int userId);
  Future<void> saveProfile(UserEntity profile, int userId);
  Future<void> deleteProfile(int userId);
  void logout();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({
    required ProfileLocalDataSource localDataSource,
    required ProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<UserEntity> getProfile(int userId) async {
    try {
      print("Trying to get profile^ ${userId}");
      final remoteProfile = await _remoteDataSource.getProfileById(userId);
      print("Remote answer: ${remoteProfile.toString()}");
      if (remoteProfile != null) {
        _localDataSource.saveProfile(remoteProfile);
        print("Local answer: ${_localDataSource.getProfile().toString()}");
      }

      return _localDataSource.getProfile();
    } catch (e) {
     rethrow;
    }
  }

  @override
  Future<void> saveProfile(UserEntity profile, int userId) async {
    _localDataSource.saveProfile(profile);
    await _remoteDataSource.saveProfile(profile, userId);
  }

  @override
  Future<void> deleteProfile(int userId) async {
    _localDataSource.clearProfile();
    await _remoteDataSource.deleteProfile(userId);
  }

  @override
  void logout() {
    _localDataSource.clearProfile();
  }
}