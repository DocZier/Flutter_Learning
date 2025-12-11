import 'package:flutter/material.dart';
import 'package:test_practic/core/models/settings/settings_model.dart';

class SettingsConstants {
  static const AppSettingsModel defaultSettings = AppSettingsModel(
      themeMode: ThemeMode.system,
      startOfTheDay: 0
  );
}