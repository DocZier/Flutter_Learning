import 'package:get_it/get_it.dart';
import 'package:test_practic/data/repositories/progress/progress_repository.dart';
import 'package:test_practic/data/datasources/local/progress_local_source.dart';
import 'package:test_practic/data/datasources/remote/progress_remote_source.dart';
import 'package:test_practic/domain/usecases/progress/compute_statistic_usecase.dart';
import 'package:test_practic/domain/usecases/progress/get_cached_statistic_usecase.dart';
import 'package:test_practic/domain/usecases/progress/get_learning_progress_history_usecase.dart';
import 'package:test_practic/domain/usecases/progress/refresh_statistic_usecase.dart';
import 'package:test_practic/domain/usecases/progress/save_statistic_usecase.dart';

void registerProgressDependencies() {
  GetIt.I.registerLazySingleton<ProgressLocalSource>(() => ProgressLocalSource());
  GetIt.I.registerLazySingleton<ProgressRemoteSource>(() => ProgressRemoteSource());
  GetIt.I.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(
      flashcardRepository: GetIt.I(),
      lessonsRepository: GetIt.I(),
      testsRepository: GetIt.I(),
      localSource: GetIt.I(),
      remoteSource: GetIt.I(),
    ),
  );

  GetIt.I.registerFactory<ComputeStatisticsUseCase>(() => ComputeStatisticsUseCase(GetIt.I<ProgressRepository>()));
  GetIt.I.registerFactory<GetCachedStatisticsUseCase>(() => GetCachedStatisticsUseCase(GetIt.I<ProgressRepository>()));
  GetIt.I.registerFactory<RefreshStatisticsUseCase>(() => RefreshStatisticsUseCase(GetIt.I<ProgressRepository>()));
  GetIt.I.registerFactory<SaveStatisticsUseCase>(() => SaveStatisticsUseCase(GetIt.I<ProgressRepository>()));
  GetIt.I.registerFactory<GetLearningProgressHistoryUseCase>(() => GetLearningProgressHistoryUseCase(GetIt.I<ProgressRepository>()));

}
