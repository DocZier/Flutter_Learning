import 'package:flutter/material.dart';

import '../../features/settings/domain/entities/settings_entity.dart';

class SettingsConstants {
  static const AppSettingsEntity defaultSettings = AppSettingsEntity(
      themeMode: ThemeMode.system,
      startOfTheDay: 0
  );
}