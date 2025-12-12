import 'package:get_it/get_it.dart';
import 'package:test_practic/data/datasources/local/database/database.dart';

import 'auth/auth_di.dart';
import 'dictionary/dictionary_di.dart';
import 'fllashcards/flashcards_di.dart';
import 'lessons/lessons_di.dart';
import 'profile/profile_di.dart';
import 'settings/settings_di.dart';
import 'progress/progress_di.dart';
import '../../data/datasources/remote/user_remote_source.dart';

void registerModule() {
  GetIt.I.registerLazySingleton<RemoteUserSource>(() => RemoteUserSource());
  GetIt.I.registerLazySingleton<AppDatabase>(() => AppDatabase());

  registerSettingsDependencies();
  registerAuthDependencies();
  registerFlashcardsDependencies();
  registerProfileDependencies();
  registerDictionaryDependencies();
  registerLessonsDependencies();
  registerProgressDependencies();
}