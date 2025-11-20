import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_practic/services/auth_service.dart';
import '../state/data_container.dart';
import '../models/decks.dart';
import '../models/flashcards.dart';

part 'app_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AppDataNotifier extends _$AppDataNotifier {
  @override
  AppData build() => const AppData(user: null);

  void _syncUserWithServer() {
    final auth = GetIt.I<AuthService>();
    auth.updateUser(state.user!);
  }

  void addDeck(Deck deck) {
    state = state.copyWith(
      user: state.user!.copyWith(decks: [...state.user!.decks, deck]),
    );
    _syncUserWithServer();
  }

  void deleteDeck(String id) {
    state = state.copyWith(
      user: state.user!.copyWith(
        decks: state.user!.decks.where((d) => d.id != id).toList(),
      ),
    );
    _syncUserWithServer();
  }

  void addCard(String deckId, Flashcard card) {
    state = state.copyWith(
      user: state.user!.copyWith(
        decks: state.user!.decks.map((deck) {
          if (deck.id == deckId) {
            return deck.copyWith(flashcards: [...deck.flashcards, card]);
          }
          return deck;
        }).toList(),
      ),
    );
    _syncUserWithServer();
  }

  void deleteCard(String deckId, String cardId) {
    state = state.copyWith(
      user: state.user!.copyWith(
        decks: state.user!.decks.map((deck) {
          if (deck.id == deckId) {
            return deck.copyWith(
              flashcards: deck.flashcards.where((c) => c.id != cardId).toList(),
            );
          }
          return deck;
        }).toList(),
      ),
    );
    _syncUserWithServer();
  }

  void updateCard(String deckId, Flashcard card, int q) {
    final updated = card.applyQuality(q);

    state = state.copyWith(
      user: state.user!.copyWith(
        decks: state.user!.decks.map((deck) {
          if (deck.id == deckId) {
            return deck.copyWith(
              flashcards: deck.flashcards.map((c) {
                return c.id == card.id ? updated : c;
              }).toList(),
            );
          }
          return deck;
        }).toList(),
      ),
    );

    _syncUserWithServer();
  }

  void setUser(UserData user) {
    state = state.copyWith(user: user);
  }

  UserData getUser() {
    return state.user!;
  }

  bool updateUserFields({
    String? username,
    String? password,
  }) {

    state = state.copyWith(
      user: state.user!.copyWith(
        username: username ?? state.user!.username,
        password: password ?? state.user!.password,
        decks: state.user!.decks,
      ),
    );

    final auth = GetIt.I<AuthService>();
    final updated = auth.updateUser(state.user!);

    return updated != null;
  }

  bool deleteUser() {
    state = state.copyWith(user: null);
    final auth = GetIt.I<AuthService>();
    return auth.deleteUser(state.user!);
  }

  bool resetUser() {
    state = state.copyWith(user: state.user!.copyWith(decks: []));
    final auth = GetIt.I<AuthService>();
    return auth.resetUser(state.user!);
  }

  void logout() {
    state = state.copyWith(user: null);
  }

  Deck getDeckById(String id) {
    return state.user!.decks.where((deck) => deck.id == id).first;
  }

  Deck getDeckByIndex(int index) {
    return state.user!.decks[index];
  }

  bool isEmpty() => state.user!.decks.isEmpty;

  int getLength() => state.user!.decks.length;
}
