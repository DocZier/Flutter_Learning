
import 'package:flutter/material.dart';
import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/datasources/local/dto/settings_dto.dart';
extension SettingsLocalMapper on SettingsLocalDto {
  AppSettingsModel toModel() {
    return AppSettingsModel(
      themeMode: _getThemeMode(themeMode),
      startOfTheDay: startOfTheDay,
    );
  }

  ThemeMode _getThemeMode(String mode) {
    switch (mode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }
}

extension SettingsModelLocalMapper on AppSettingsModel {
  SettingsLocalDto toLocalDto() {
    return SettingsLocalDto(
      themeMode: _getThemeModeString(themeMode),
      startOfTheDay: startOfTheDay,
    );
  }

  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }
}