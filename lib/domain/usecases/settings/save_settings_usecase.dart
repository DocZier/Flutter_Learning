import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/repositories/settings/settings_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart';

class SaveSettingsUseCase {
  final SettingsRepository repository;

  SaveSettingsUseCase(this.repository);

  Future<void> execute(AppSettingsModel settings, int? userId) async {
    await repository.saveSettings(settings, userId);
  }
}