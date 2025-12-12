import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart';

class GetLocalSettingsUseCase {
  final SettingsRepository repository;

  GetLocalSettingsUseCase(this.repository);

  Future<AppSettingsModel?> execute() async {
    return await repository.getLocalSettings();
  }
}