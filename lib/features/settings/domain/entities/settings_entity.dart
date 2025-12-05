import 'package:flutter/material.dart';

class AppSettingsEntity {
  final ThemeMode themeMode;
  final int startOfTheDay;

  const AppSettingsEntity({
    this.themeMode = ThemeMode.system,
    required this.startOfTheDay,
  });

  AppSettingsEntity copyWith({
    int? startOfTheDay,
    ThemeMode? themeMode,
  }) {
    return AppSettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      startOfTheDay: startOfTheDay ?? this.startOfTheDay,
    );
  }
}