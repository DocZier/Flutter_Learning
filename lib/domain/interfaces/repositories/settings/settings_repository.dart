import 'package:test_practic/core/models/settings/settings_model.dart';

abstract class SettingsRepository {
  AppSettingsModel? getLocalSettings();
  Future<AppSettingsModel?> getSettingsForUser(int userId);
  Future<void> saveSettings(AppSettingsModel settings, int? userId);
  Future<void> resetSettings(int? userId);
}
