import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_practic/core/models/fllashcards/deck_model.dart';
import 'package:test_practic/core/models/fllashcards/flashcards_model.dart';
import 'package:test_practic/presentation/features/fllashcards/providers/deck_flashcards_provider.dart';


class DeckListItem extends ConsumerWidget {
  final DeckModel deck;
  final void Function(String deckId) onTapEmpty;
  final void Function(String deckId) onTapFull;
  final void Function(String deckId) onLongPress;

  const DeckListItem({
    super.key,
    required this.deck,
    required this.onTapEmpty,
    required this.onTapFull,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcardsAsync = ref.watch(deckFlashcardsProvider(deck.id));

    return flashcardsAsync.when(
      loading: () => _buildLoadingItem(deck, context),
      error: (error, stack) => _buildErrorItem(deck, error.toString(), context),
      data: (flashcards) => _buildDeckItem(deck, flashcards, context),
    );
  }

  Widget _buildLoadingItem(DeckModel deck, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(deck.title),
        subtitle: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorItem(DeckModel deck, String error, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(deck.title),
        subtitle: Text('Ошибка: $error'),
      ),
    );
  }

  Widget _buildDeckItem(DeckModel deck, List<FlashcardModel> flashcards, BuildContext context) {
    final dueCount = flashcards.where((flashcard) =>
        flashcard.nextReview.isBefore(DateTime.now())
    ).length;

    final totalCount = flashcards.where((flashcard) =>
        flashcard.nextReview.isAfter(DateTime.now())
    ).length;

    return Card(
      child: InkWell(
        onTap: () =>
        flashcards.isEmpty ? onTapEmpty(deck.id) : onTapFull(deck.id),
        onLongPress: () => onLongPress(deck.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  deck.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                totalCount.toString(),
                style: TextStyle(
                  color: totalCount > 0 ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                dueCount.toString(),
                style: TextStyle(
                  color: dueCount > 0 ? Colors.blue : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
