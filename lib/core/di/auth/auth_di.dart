import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:test_practic/domain/usecases/auth/login_usecase.dart';
import 'package:test_practic/domain/usecases/auth/logout_usecase.dart';
import 'package:test_practic/domain/usecases/auth/register_usecase.dart';
import 'package:test_practic/domain/usecases/profile/delete_account_usecase.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/datasources/local/auth/auth_local_source.dart';
import '../../../data/datasources/remote/auth/auth_remote_source.dart';

void registerAuthDependencies() {
  GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(),
  );

  GetIt.I.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );

  GetIt.I.registerFactory<LoginUseCase>(() => LoginUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerFactory<RegisterUseCase>(() => RegisterUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerFactory<CheckAuthStatusUseCase>(() => CheckAuthStatusUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerFactory<LogoutUseCase>(() => LogoutUseCase(GetIt.I<AuthRepository>()));
  GetIt.I.registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase(GetIt.I<AuthRepository>()));
}
