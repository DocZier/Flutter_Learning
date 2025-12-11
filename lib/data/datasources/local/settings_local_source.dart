import 'package:flutter/material.dart';
import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/datasources/local/dto/mappers/settings_mapper.dart';
import 'package:test_practic/data/datasources/local/dto/settings_dto.dart';

import '../../../core/constants/settings_constants.dart';


class SettingsLocalDataSource {
  static final Map<String, dynamic> _storage = {
    'theme_mode': 'system',
    'start_of_the_day': 0,
  };

  AppSettingsModel getSettings() {
    return SettingsLocalDto.fromJson(_storage).toModel();
  }

  void saveSettings(AppSettingsModel settings) {
    _storage.addAll(settings.toLocalDto().toJson());
  }

  void resetSettings(AppSettingsModel defaultSettings) {
    saveSettings(defaultSettings);
  }
}