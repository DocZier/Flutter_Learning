import 'package:get_it/get_it.dart';

import '../data/repositories/lessons_repository.dart';
import '../data/repositories/test_repository.dart';
import '../data/sources/local/lessons_local_source.dart';
import '../data/sources/local/test_local_source.dart';
import '../data/sources/remote/lessons_remote_source.dart';
import '../data/sources/remote/test_remote_source.dart';

void registerLessonsDependencies() {
  GetIt.I.registerLazySingleton<LessonsLocalDataSource>(
        () => LessonsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<LessonsRemoteDataSource>(
        () => LessonsRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<TestsLocalDataSource>(
        () => TestsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<TestsRemoteDataSource>(
        () => TestsRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<TestsRepository>(
        () => TestsRepositoryImpl(
      localDataSource: GetIt.I(),
      remoteDataSource:  GetIt.I(),
    ),
  );

  GetIt.I.registerLazySingleton<LessonsRepository>(
        () => LessonsRepositoryImpl(
      localDataSource:  GetIt.I(),
      remoteDataSource: GetIt.I(),
    ),
  );

}