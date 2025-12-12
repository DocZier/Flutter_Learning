import 'package:test_practic/data/repositories/settings/settings_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart';

class ResetSettingsUseCase {
  final SettingsRepository repository;

  ResetSettingsUseCase(this.repository);

  Future<void> execute(int? userId) async {
    await repository.resetSettings(userId);
  }
}