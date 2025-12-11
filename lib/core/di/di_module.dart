import 'package:get_it/get_it.dart';

import 'auth/auth_di.dart';
import 'dictionary/dictionary_di.dart';
import 'fllashcards/flashcards_di.dart';
import 'lessons/lessons_di.dart';
import 'profile/profile_di.dart';
import 'settings/settings_di.dart';
import 'progress/progress_di.dart';
import '../../data/datasources/remote/shared/remote_user_source.dart';

void registerModule() {
  GetIt.I.registerLazySingleton<RemoteUserSource>(() => RemoteUserSource());

  registerSettingsDependencies();
  registerAuthDependencies();
  registerFlashcardsDependencies();
  registerProfileDependencies();
  registerDictionaryDependencies();
  registerLessonsDependencies();
  registerProgressDependencies();
}