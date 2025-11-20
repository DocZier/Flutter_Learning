import '../../../../core/constants/settings_constants.dart';
import '../../domain/entities/settings_entity.dart';
import '../sources/local/settings_local_source.dart';
import '../sources/remote/settings_remote_source.dart';

abstract class SettingsRepository {
  AppSettingsEntity? getLocalSettings();
  Future<AppSettingsEntity?> getSettingsForUser(int userId);
  Future<void> saveSettings(AppSettingsEntity settings, int? userId);
  Future<void> resetSettings(int? userId);
}

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  AppSettingsEntity getLocalSettings() {
    try {
      final localSettings = _localDataSource.getSettings();
      return localSettings;
    } catch (e) {
      return SettingsConstants.defaultSettings;
    }
  }

  @override
  Future<AppSettingsEntity?> getSettingsForUser(int userId) async {
    try {
      final remoteSettings = await _remoteDataSource.getSettingsById(userId);

      if (remoteSettings != null) {
        _localDataSource.saveSettings(remoteSettings);
        return remoteSettings;
      }

      return _localDataSource.getSettings();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings, int? userId) async {
    try {
      _localDataSource.saveSettings(settings);
      if (userId != null) {
        await _remoteDataSource.saveSettings(settings, userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetSettings(int? userId) async {
    try {
      _localDataSource.resetSettings();

      if (userId != null) {
        await _remoteDataSource.resetSettings(userId);
      }
    } catch (e) {
      rethrow;
    }
  }
}