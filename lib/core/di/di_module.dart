import '../../features/auth/di/auth_di.dart';
import '../../features/flashcards/di/flashcards_di.dart';
import '../../features/settings/di/settings_di.dart';

void registerModule() {
  registerSettingsDependencies();
  registerAuthDependencies();
  registerFlashcardsDependencies();
}