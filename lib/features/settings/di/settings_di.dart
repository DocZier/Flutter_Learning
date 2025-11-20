import 'package:get_it/get_it.dart';

import '../data/repositories/settings_repository.dart';
import '../data/sources/local/settings_local_source.dart';
import '../data/sources/remote/settings_remote_source.dart';

void registerSettingsDependencies() {
  GetIt.I.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(
      SettingsLocalDataSource(),
      SettingsRemoteDataSource(),
    ),
  );
}