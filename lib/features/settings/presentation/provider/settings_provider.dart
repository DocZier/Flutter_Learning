import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import '../../data/model/settings_model.dart';
import '../../data/repositories/settings_repository.dart';
import '../states/settings_state.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  late final SettingsRepository _settingsRepository;

  @override
  Future<SettingsState> build() async {
    _settingsRepository = GetIt.I<SettingsRepository>();
    final settings = await _loadSettings();
    return SettingsState(settings: settings);
  }

  Future<AppSettings> _loadSettings() async {
    try {
      final entity = _settingsRepository.getLocalSettings();
      if (entity == null) {
        return AppSettings.defaultSettings();
      }
      return AppSettings.fromEntity(entity);
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }

  Future<void> updateSettings(AppSettings settings) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final user = 1; //(ref.read(authProvider) as Authenticated).user;
      await _settingsRepository.saveSettings(settings.toEntity(), user);
      state = AsyncValue.data(
          state.value!.copyWith(settings: settings)
      );
    } catch (e) {
      throw Exception(e);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> resetSettings() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    //final user = ref.read(authProvider);
    try {
      final userId = 1; //(user as Authenticated).user.id;
      await _settingsRepository.resetSettings(userId);
      state = AsyncValue.data(
          state.value!.copyWith(settings: AppSettings.defaultSettings())
      );
    } catch (e) {
     /* if (user is Unauthenticated) {
        state = AsyncValue.data(
            state.value!.copyWith(settings: AppSettings.defaultSettings())
        );
      }*/
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(themeMode: themeMode);
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updateStartOfTheDay(int startOfTheDay) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(startOfTheDay: startOfTheDay);
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }
}