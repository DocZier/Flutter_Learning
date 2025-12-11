import 'package:get_it/get_it.dart';
import 'package:test_practic/data/repositories/fllashcards/flashcard_repository.dart';
import 'package:test_practic/data/datasources/local/fllashcards/deck_local_source.dart';
import 'package:test_practic/data/datasources/local/fllashcards/flashcards_local_source.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_deck_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_flashcard_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/delete_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_deck_by_id_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_flashcards_by_deckid_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/get_user_decks_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_deck_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/save_flashcard_usecase.dart';
import 'package:test_practic/domain/usecases/fllashcards/update_flashcard_usecase.dart';

import '../../../data/datasources/remote/fllashcards/deck_remote_source.dart';
import '../../../data/datasources/remote/fllashcards/flashcards_remote_source.dart';

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

  GetIt.I.registerFactory<GetFlashcardsByDeckIdUseCase>(() => GetFlashcardsByDeckIdUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<SaveFlashcardUseCase>(() => SaveFlashcardUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<RemoveFlashcardUseCase>(() => RemoveFlashcardUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<RemoveFlashcardsByDeckIdUseCase>(() => RemoveFlashcardsByDeckIdUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<GetUsersDecksUseCase>(() => GetUsersDecksUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<SaveDeckUseCase>(() => SaveDeckUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<RemoveDeckUseCase>(() => RemoveDeckUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<GetDeckByIdUseCase>(() => GetDeckByIdUseCase(GetIt.I<FlashcardRepository>()));
  GetIt.I.registerFactory<UpdateFlashcardUseCase>(() => UpdateFlashcardUseCase(GetIt.I<FlashcardRepository>()));

}