import 'package:get_it/get_it.dart';

import '../../features/auth/di/auth_di.dart';
import '../../features/dictionary/di/dictionary_di.dart';
import '../../features/flashcards/di/flashcards_di.dart';
import '../../features/lessons/di/lessons_di.dart';
import '../../features/profile/di/profile_di.dart';
import '../../features/settings/di/settings_di.dart';
import '../../features/stats/di/stats_di.dart';
import '../../shared/data/remote_user_source.dart';

void registerModule() {
  GetIt.I.registerLazySingleton<RemoteUserSource>(() => RemoteUserSource());

  registerSettingsDependencies();
  registerAuthDependencies();
  registerFlashcardsDependencies();
  registerProfileDependencies();
  registerDictionaryDependencies();
  registerLessonsDependencies();
  registerStatsDependencies();
}