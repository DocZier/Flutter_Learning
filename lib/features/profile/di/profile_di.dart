
import 'package:get_it/get_it.dart';

import '../data/repositories/profile_repository.dart';
import '../data/sources/local/profile_local_source.dart';
import '../data/sources/remote/profile_remote_source.dart';

void registerProfileDependencies() {
  GetIt.I.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      localDataSource: GetIt.I<ProfileLocalDataSource>(),
      remoteDataSource: GetIt.I<ProfileRemoteDataSource>(),
    ),
  );
}