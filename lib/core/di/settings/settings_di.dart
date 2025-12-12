import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/interfaces/repositories/settings/settings_repository.dart';
import 'package:test_practic/domain/usecases/settings/get_local_settings_usecase.dart';
import 'package:test_practic/domain/usecases/settings/get_settings_for_user_usecase.dart';
import 'package:test_practic/domain/usecases/settings/reset_user_settings_usecase.dart';
import 'package:test_practic/domain/usecases/settings/save_settings_usecase.dart';

import '../../../data/repositories/settings/settings_repository.dart';
import '../../../data/datasources/local/settings_local_source.dart';
import '../../../data/datasources/remote/settings_remote_source.dart';

void registerSettingsDependencies() {
  GetIt.I.registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(
          GetIt.I(),
          GetIt.I(),
    ),
  );

  GetIt.I.registerFactory<GetLocalSettingsUseCase>(() => GetLocalSettingsUseCase(GetIt.I<SettingsRepository>()));
  GetIt.I.registerFactory<GetSettingsForUserUseCase>(() => GetSettingsForUserUseCase(GetIt.I<SettingsRepository>()));
  GetIt.I.registerFactory<SaveSettingsUseCase>(() => SaveSettingsUseCase(GetIt.I<SettingsRepository>()));
  GetIt.I.registerFactory<ResetSettingsUseCase>(() => ResetSettingsUseCase(GetIt.I<SettingsRepository>()));

}