import 'package:get_it/get_it.dart';
import 'package:test_practic/data/datasources/remote/dictionary_remote_source.dart';
import 'package:test_practic/domain/usecases/dictionary/clear_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/delete_word_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_saved_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_word_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_word_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_words_usecase.dart';

import '../../../data/repositories/dictionary/dictionary_repository.dart';
import '../../../data/datasources/local/dictionary_local_source.dart';

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

  GetIt.I.registerFactory<GetWordsUseCase>(() => GetWordsUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<GetWordByIdUseCase>(() => GetWordByIdUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<GetSavedWordsUseCase>(() => GetSavedWordsUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<SearchWordsUseCase>(() => SearchWordsUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<SaveWordUseCase>(() => SaveWordUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<DeleteWordUseCase>(() => DeleteWordUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<GetHistoryUseCase>(() => GetHistoryUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<SaveHistoryUseCase>(() => SaveHistoryUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<ClearHistoryUseCase>(() => ClearHistoryUseCase(GetIt.I<DictionaryRepository>()));

}
