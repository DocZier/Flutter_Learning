import 'package:test_practic/core/models/settings/settings_entity.dart';
import 'package:test_practic/data/repositories/settings/settings_repository.dart';

class GetSettingsForUserUseCase {
  final SettingsRepository repository;

  GetSettingsForUserUseCase(this.repository);

  Future<AppSettingsEntity?> execute(int userId) async {
    return await repository.getSettingsForUser(userId);
  }
}
