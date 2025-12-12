import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart' show SettingsRepository;
import '../../../core/constants/settings_constants.dart';
import '../../datasources/local/settings_local_source.dart';
import '../../datasources/remote/settings_remote_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(
      this._localDataSource,
      this._remoteDataSource,
      );

  @override
  Future<AppSettingsModel> getLocalSettings() async{
    try {
      return await _localDataSource.getSettings();
    } catch (e) {
      return SettingsConstants.defaultSettings;
    }
  }

  @override
  Future<AppSettingsModel?> getSettingsForUser(int userId) async {
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
  Future<void> saveSettings(AppSettingsModel settings, int? userId) async {
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
      final defaultSettings = SettingsConstants.defaultSettings;
      _localDataSource.resetSettings(defaultSettings);
      if (userId != null) {
        await _remoteDataSource.resetSettings(userId, defaultSettings);
      }
    } catch (e) {
      rethrow;
    }
  }
}