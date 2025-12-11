import 'package:flutter/material.dart';
import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/datasources/remote/dto/mappers/settings_mapper.dart';
import 'package:test_practic/data/datasources/remote/dto/settings_dto.dart';
import '../../../core/constants/settings_constants.dart';

class SettingsRemoteDataSource {
  static final List<SettingsRemoteDto> _settings = [
    SettingsRemoteDto(
      id: '1',
      userId: '1',
      themeMode: 'system',
      startOfTheDay: 0,
    ),
  ];

  Future<AppSettingsModel?> getSettingsById(int userId) async {
    try {
      final settings = _settings.firstWhere(
            (s) => s.userId == userId.toString(),
      );
      return settings.toModel();
    } catch (e) {
      return null;
    }
  }

  Future<void> resetSettings(int? userId, AppSettingsModel defaultSettings) async {
    await saveSettings(defaultSettings, userId);
  }

  Future<void> saveSettings(AppSettingsModel settings, int? userId) async {
    final index = _settings.indexWhere((s) => s.userId == userId.toString());
    if (index == -1) {
      _settings.add(settings.toRemoteDto(userId: userId));
    } else {
      _settings[index] = settings.toRemoteDto(userId: userId);
    }
  }
}