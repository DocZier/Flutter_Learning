import 'package:get_it/get_it.dart';

import '../data/repositories/auth_repository.dart';
import '../data/sources/local/auth_local_source.dart';
import '../data/sources/remote/auth_remote_source.dart';

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
}
