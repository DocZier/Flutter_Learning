
import 'package:get_it/get_it.dart';
import 'package:test_practic/data/datasources/remote/api/configuration/dio_client.dart';
import 'package:test_practic/data/datasources/remote/api/dictionary_remote_source.dart';
import 'package:test_practic/data/datasources/remote/api/kanji_remote_source.dart';
import 'package:test_practic/domain/interfaces/repositories/dictionary/dictionary_repository.dart';
import 'package:test_practic/domain/usecases/dictionary/clear_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/delete_word_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_kanji_details_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_kanji_examples_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_saved_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_word_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/get_words_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_history_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/save_word_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_kanji_by_character_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_kanji_usecase.dart';
import 'package:test_practic/domain/usecases/dictionary/search_words_usecase.dart';

import '../../../data/repositories/dictionary/dictionary_repository.dart';
import '../../../data/datasources/local/dictionary_local_source.dart';

void registerDictionaryDependencies() {
  GetIt.I.registerLazySingleton<DioClient>(() => DioClient());
  GetIt.I.registerLazySingleton<DictionaryLocalDataSource>(
        () => DictionaryLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<DictionaryRemoteDataSource>(
        () => DictionaryRemoteDataSource(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<KanjiRemoteDataSource>(
        () => KanjiRemoteDataSource(GetIt.I()),
  );

  GetIt.I.registerLazySingleton<DictionaryRepository>(
        () => DictionaryRepositoryImpl(
      localDataSource: GetIt.I(),
      remoteDataSource: GetIt.I(),
      kanjiRemoteDataSource: GetIt.I(),
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
  GetIt.I.registerFactory<SearchKanjiByCharacterUseCase>(() => SearchKanjiByCharacterUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<GetKanjiDetailsUseCase>(() => GetKanjiDetailsUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<SearchKanjiUseCase>(() => SearchKanjiUseCase(GetIt.I<DictionaryRepository>()));
  GetIt.I.registerFactory<GetKanjiExamplesUseCase>(() => GetKanjiExamplesUseCase(GetIt.I<DictionaryRepository>()));
}
