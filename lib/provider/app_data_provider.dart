import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/data_container.dart';
import '../models/decks.dart';
import '../models/flashcards.dart';

part 'app_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AppDataNotifier extends _$AppDataNotifier {
  @override
  AppData build() {
    return AppData(decks: []);
  }

  void addDeck(Deck deck) {
    state = state.copyWith(decks: [...state.decks, deck]);
  }

  void deleteDeck(String id) {
    state = state.copyWith(
      decks: state.decks.where((d) => d.id != id).toList(),
    );
  }

  void addCard(String deckId, Flashcard card) {
    state = state.copyWith(
      decks: state.decks.map((deck) {
        if (deck.id == deckId) {
          return deck.copyWith(flashcards: [...deck.flashcards, card]);
        }
        return deck;
      }).toList(),
    );
  }

  void deleteCard(String deckId, String cardId) {
    state = state.copyWith(
      decks: state.decks.map((deck) {
        if (deck.id == deckId) {
          return deck.copyWith(
            flashcards: deck.flashcards.where((c) => c.id != cardId).toList(),
          );
        }
        return deck;
      }).toList(),
    );
  }

  void updateCard(String deckId, Flashcard card, int q) {
    final updated = card.applyQuality(q);

    state = state.copyWith(
      decks: state.decks.map((deck) {
        if (deck.id == deckId) {
          return deck.copyWith(
            flashcards: deck.flashcards.map((c) {
              return c.id == card.id ? updated : c;
            }).toList(),
          );
        }
        return deck;
      }).toList(),
    );
  }

  Deck getDeckById(String id) {
    return state.decks.where((deck) => deck.id == id).first;
  }

  Deck getDeckByIndex(int index) {
    return state.decks[index];
  }

  bool isEmpty() {
    return state.decks.isEmpty;
  }

  int getLength() {
    return state.decks.length;
  }
}