import 'package:flutter/material.dart';

import '../../../../core/constants/settings_constants.dart';
import '../../../../core/models/settings/settings_entity.dart';

class SettingsLocalDataSource {
  static final Map<String, dynamic> _storage = {
    'theme_mode': 'system',
    'start_of_the_day': 0,
  };

  AppSettingsEntity getSettings() {
    return AppSettingsEntity(
        themeMode: _getThemeMode(_storage['theme_mode'] as String? ?? 'system'),
        startOfTheDay: _storage['start_of_the_day'] as int? ?? 0,
    );
  }

  void saveSettings(AppSettingsEntity settings) {

    _storage['theme_mode'] = _getThemeModeString(settings.themeMode);
    _storage['start_of_the_day'] = settings.startOfTheDay;
  }

  void resetSettings() {
    saveSettings(SettingsConstants.defaultSettings);
  }

  ThemeMode _getThemeMode(String mode) {
    switch (mode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }
}