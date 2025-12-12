import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_practic/core/models/settings/settings_model.dart';


class SettingsLocalDataSource {
  static const _themeModeKey = 'theme_mode';
  static const _startOfTheDayKey = 'start_of_the_day';

  Future<AppSettingsModel> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_themeModeKey) ?? 'system';
    final startOfTheDay = prefs.getInt(_startOfTheDayKey) ?? 0;

    return AppSettingsModel(
      themeMode: _getThemeMode(themeMode),
      startOfTheDay: startOfTheDay,
    );
  }

  Future<void> saveSettings(AppSettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, _getThemeModeString(settings.themeMode));
    await prefs.setInt(_startOfTheDayKey, settings.startOfTheDay);
  }

  Future<void> resetSettings(AppSettingsModel defaultSettings) async {
    await saveSettings(defaultSettings);
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