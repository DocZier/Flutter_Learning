
import 'package:get_it/get_it.dart';
import 'package:test_practic/domain/usecases/profile/delete_profile_usecase.dart';
import 'package:test_practic/domain/usecases/profile/get_profile_usecase.dart';
import 'package:test_practic/domain/usecases/profile/save_profile_usecase.dart';

import '../../../data/repositories/profile/profile_repository.dart';
import '../../../data/datasources/local/profile_local_source.dart';
import '../../../data/datasources/remote/profile_remote_source.dart';

void registerProfileDependencies() {
  GetIt.I.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSource(GetIt.I()),
  );

  GetIt.I.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      localDataSource: GetIt.I<ProfileLocalDataSource>(),
      remoteDataSource: GetIt.I<ProfileRemoteDataSource>(),
    ),
  );

  GetIt.I.registerFactory<GetProfileUseCase>(() => GetProfileUseCase(GetIt.I<ProfileRepository>()));
  GetIt.I.registerFactory<SaveProfileUseCase>(() => SaveProfileUseCase(GetIt.I<ProfileRepository>()));
  GetIt.I.registerFactory<DeleteProfileUseCase>(() => DeleteProfileUseCase(GetIt.I<ProfileRepository>()));

}