import 'package:get_it/get_it.dart';
import 'package:test_practic/features/stats/data/repositories/stats_repository.dart';
import 'package:test_practic/features/stats/data/sources/local/stats_local_source.dart';
import 'package:test_practic/features/stats/data/sources/remote/stats_remote_source.dart';

void registerStatsDependencies() {
  GetIt.I.registerLazySingleton<StatsLocalSource>(() => StatsLocalSource());
  GetIt.I.registerLazySingleton<StatsRemoteSource>(() => StatsRemoteSource());
  GetIt.I.registerLazySingleton<StatsRepository>(
    () => StatsRepositoryImpl(
      flashcardRepository: GetIt.I(),
      lessonsRepository: GetIt.I(),
      testsRepository: GetIt.I(),
      localSource: GetIt.I(),
      remoteSource: GetIt.I(),
    ),
  );
}
