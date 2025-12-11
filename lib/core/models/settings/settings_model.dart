import 'package:flutter/material.dart';

import '../../constants/settings_constants.dart';
import 'settings_entity.dart';

class AppSettings extends AppSettingsEntity {
  const AppSettings({
    required super.themeMode,
    required super.startOfTheDay,
  });

  @override
  AppSettings copyWith({
    ThemeMode? themeMode,
    int? startOfTheDay,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      startOfTheDay: startOfTheDay ?? this.startOfTheDay,
    );
  }

  AppSettings copyFromModel(AppSettings settings) {
    return AppSettings(
        themeMode: settings.themeMode,
        startOfTheDay: settings.startOfTheDay,
    );
  }

  factory AppSettings.fromEntity(AppSettingsEntity entity) {
    return AppSettings(
        themeMode: entity.themeMode,
        startOfTheDay: entity.startOfTheDay,
    );
  }

  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
        themeMode: themeMode,
        startOfTheDay: startOfTheDay,
    );
  }

  factory AppSettings.defaultSettings() {
    return AppSettings.fromEntity(SettingsConstants.defaultSettings);
  }

}