import 'package:get_it/get_it.dart';
import 'package:test_practic/features/flashcards/data/repositories/flashcard_repository.dart';
import 'package:test_practic/features/flashcards/data/source/local/deck_local_source.dart';
import 'package:test_practic/features/flashcards/data/source/local/flashcards_local_source.dart';

import '../data/source/remote/deck_remote_source.dart';
import '../data/source/remote/flashcards_remote_source.dart';

void registerFlashcardsDependencies() {
  GetIt.I.registerLazySingleton<FlashcardsLocalSource>(
        () => FlashcardsLocalSource(),
  );
  GetIt.I.registerLazySingleton<FlashcardsRemoteSource>(
        () => FlashcardsRemoteSource(),
  );
  GetIt.I.registerLazySingleton<DeckLocalSource>(
        () => DeckLocalSource(),
  );
  GetIt.I.registerLazySingleton<DeckRemoteSource>(
        () => DeckRemoteSource(),
  );
  GetIt.I.registerLazySingleton<FlashcardRepository>(
        () => FlashcardRepositoryImpl(
          remoteDeckSource: GetIt.I(),
          remoteFlashcardSource: GetIt.I(),
          localDeckSource: GetIt.I(),
          localFlashcardSource: GetIt.I(),
    ),
  );
}