import 'package:get_it/get_it.dart';
import 'package:test_practic/features/dictionary/data/sources/remote/dictionary_remote_source.dart';

import '../data/repositories/dictionary_repository.dart';
import '../data/sources/local/dictionary_local_source.dart';

void registerDictionaryDependencies() {
  GetIt.I.registerLazySingleton<DictionaryLocalDataSource>(
        () => DictionaryLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<DictionaryRemoteDataSource>(
        () => DictionaryRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<DictionaryRepository>(
        () => DictionaryRepositoryImpl(
      localDataSource: GetIt.I(),
      remoteDataSource: GetIt.I(),
    ),
  );
}
