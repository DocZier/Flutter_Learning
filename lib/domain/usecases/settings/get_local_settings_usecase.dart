import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/repositories/settings/settings_repository.dart';

class GetLocalSettingsUseCase {
  final SettingsRepository repository;

  GetLocalSettingsUseCase(this.repository);

  AppSettingsModel? execute() {
    return repository.getLocalSettings();
  }
}