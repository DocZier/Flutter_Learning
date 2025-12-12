import 'package:test_practic/core/models/settings/settings_model.dart';
import 'package:test_practic/data/repositories/settings/settings_repository.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart';

class GetSettingsForUserUseCase {
  final SettingsRepository repository;

  GetSettingsForUserUseCase(this.repository);

  Future<AppSettingsModel?> execute(int userId) async {
    return await repository.getSettingsForUser(userId);
  }
}
