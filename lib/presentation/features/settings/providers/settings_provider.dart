import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/settings/get_local_settings_usecase.dart';
import 'package:test_practic/domain/usecases/settings/get_settings_for_user_usecase.dart';
import 'package:test_practic/domain/usecases/settings/reset_user_settings_usecase.dart';
import 'package:test_practic/domain/usecases/settings/save_settings_usecase.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';
import '../../../../core/models/settings/settings_model.dart';
import '../states/settings_state.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  late final int? _userId;

  @override
  Future<SettingsState> build() async {
    final authState = ref.watch(authProvider);
    _userId = authState is Authenticated ? authState.user.id : null;

    final settings = await _loadSettings();
    return SettingsState(settings: settings);
  }

  Future<AppSettings> _loadSettings() async {
    try {
      if (_userId != null) {
        final getSettingsForUserUseCase = GetIt.I<GetSettingsForUserUseCase>();
        final entity = await getSettingsForUserUseCase.execute(_userId);
        return entity != null ? AppSettings.fromEntity(entity) : AppSettings.defaultSettings();
      }

      final getLocalSettingsUseCase = GetIt.I<GetLocalSettingsUseCase>();
      final entity = getLocalSettingsUseCase.execute();
      return entity != null ? AppSettings.fromEntity(entity) : AppSettings.defaultSettings();
    } catch (e) {
      return AppSettings.defaultSettings();
    }
  }

  Future<void> updateSettings(AppSettings settings) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final saveSettingsUseCase = GetIt.I<SaveSettingsUseCase>();
      await saveSettingsUseCase.execute(settings.toEntity(), _userId);
      state = AsyncValue.data(state.value!.copyWith(settings: settings));
    } catch (e) {
      throw Exception(e);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> resetSettings() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final resetSettingsUseCase = GetIt.I<ResetSettingsUseCase>();
      await resetSettingsUseCase.execute(_userId);
      state = AsyncValue.data(state.value!.copyWith(
          settings: AppSettings.defaultSettings()
      ));
    } catch (e) {
      if (_userId == null) {
        state = AsyncValue.data(state.value!.copyWith(
            settings: AppSettings.defaultSettings()
        ));
      }
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