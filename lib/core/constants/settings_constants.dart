import 'package:flutter/material.dart';

import '../models/settings/settings_entity.dart';

class SettingsConstants {
  static const AppSettingsEntity defaultSettings = AppSettingsEntity(
      themeMode: ThemeMode.system,
      startOfTheDay: 0
  );
}