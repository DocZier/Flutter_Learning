import 'package:flutter/material.dart';

import '../../../../../core/constants/settings_constants.dart';
import '../../../domain/entities/settings_entity.dart';

class SettingsRemoteDataSource {
  static final List<Map<String, dynamic>> _settings = [
    {
      'id': '1',
      'userId': '1',
      'theme': 'system',
      'start_of_the_day': 0,
    },
  ];

  Future<AppSettingsEntity?> getSettingsById(int userId) async {
    final settings = _settings.firstWhere(
          (s) => int.parse(s['userId']) == userId,
    );
    return AppSettingsEntity(
        themeMode: _getThemeMode(settings['theme']),
        startOfTheDay: settings['start_of_the_day'],
    );
  }

  ThemeMode _getThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> resetSettings(int? userId) async {
    saveSettings(SettingsConstants.defaultSettings, userId);
  }

  Future<void> saveSettings(AppSettingsEntity settings, int? userId) async {
    if (userId == null) {
      _settings.add({
        'id': _settings.length.toString(),
        'userId': userId,
        'theme': settings.themeMode,
        'start_of_the_day': settings.startOfTheDay,
      });
    } else {
      final index = _settings.indexWhere(
            (s) => int.parse(s['userId']) == userId,
      );
      if (index == -1) {
        throw Exception('User not found');
      }
      _settings[index] = {
        'userId': userId.toString(),
        'theme': settings.themeMode,
        'start_of_the_day': settings.startOfTheDay,
      };
    }
  }
}