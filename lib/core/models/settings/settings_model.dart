import 'package:flutter/material.dart';

class AppSettingsModel {
  final ThemeMode themeMode;
  final int startOfTheDay;

  const AppSettingsModel({
    this.themeMode = ThemeMode.system,
    required this.startOfTheDay,
  });

  AppSettingsModel copyWith({
    int? startOfTheDay,
    ThemeMode? themeMode,
  }) {
    return AppSettingsModel(
      themeMode: themeMode ?? this.themeMode,
      startOfTheDay: startOfTheDay ?? this.startOfTheDay,
    );
  }
}