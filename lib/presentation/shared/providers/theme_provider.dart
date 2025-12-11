import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/core/constants/settings_constants.dart';
import 'package:test_practic/presentation/features/settings/providers/settings_provider.dart';

import '../states/theme_state.dart';

part 'theme_provider.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeState build() {
    ref.listen(settingsProvider, (previous, next) {
      if (next.hasValue && next.value!.settings != null) {
        state = state.copyWith(
          themeMode: next.value!.settings!.themeMode,
          themeData: _buildThemeData(
            Colors.deepPurple,
            next.value!.settings!.themeMode,
          ),
        );
      }
    });

    return ThemeState(
      themeData: _buildThemeData(
        Colors.deepPurple,
        SettingsConstants.defaultSettings.themeMode,
      ),
      themeMode: SettingsConstants.defaultSettings.themeMode,
    );
  }
}

ThemeData _buildThemeData(Color primaryColor, ThemeMode themeMode) {
  final isDark = themeMode == ThemeMode.dark;
  return ThemeData(
    useMaterial3: true,
    brightness: isDark ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: isDark ? Brightness.dark : Brightness.light,
    ),
  );
}