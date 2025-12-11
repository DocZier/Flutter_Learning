import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_practic/presentation/shared/widgets/deck/deck_view.dart';

import '../../../shared/providers/auth_provider.dart';
import '../../../shared/states/auth_state.dart';
import '../../../../core/models/fllashcards/deck_model.dart';
import '../providers/deck_provider.dart';

const deckIcon = 'https://cdn-icons-png.flaticon.com/512/17554/17554945.png';
const emptyListIcon =
    'https://cdn-icons-png.flaticon.com/512/18895/18895859.png';
const addDeckIcon = 'https://cdn-icons-png.flaticon.com/512/2311/2311991.png';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _createNewDeck(BuildContext context, WidgetRef ref) {
    String deckName = '';
    String deckDescription = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая колода'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckName = value,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (deckName.isNotEmpty) {
                final authState = ref.read(authProvider);
                if (authState is! Authenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Пользователь не авторизован")),
                  );
                  return;
                }

                final userId = authState.user.id;
                print('Before add');
                await ref.read(deckProvider.notifier).addDeck(
                  Deck(
                    userId: userId,
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: deckName,
                    description: deckDescription,
                  ),
                );
                print('After add');

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Колода создана успешно")),
                );
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckState = ref.watch(deckProvider);
    print('Current state: ${deckState.decks.length}');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImage(
              imageUrl: deckIcon,
              height: 24,
              width: 24,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              fit: BoxFit.contain,
            ),
            Text('Колоды'),
          ],
        ),
      ),
      body: deckState.decks.isEmpty ?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: emptyListIcon,
              height: 160,
              width: 160,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              fit: BoxFit.contain,
            ),
            Text(
              'Отсутствуют колоды',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          :
      ListView.builder(
        itemCount: deckState.decks.length,
        itemBuilder: (_, index) {
          final deck = deckState.decks[index];
          final flashcards = ref.read(deckProvider.notifier).getFlashcardsByDeckId(deck.id);
          return DeckListItem(
            deck: deck,
            flashcards: flashcards,
            onTapEmpty: (test) {
              Router.neglect(context, () {
                context.push('/add_flashcard', extra: {'deckId': deck.id});
              });
            },
            onTapFull: (test) {
              context.push('/study', extra: {'deckId': deck.id});
            },
            onLongPress: (test) {
              context.push('/deck_detail', extra: {'deckId': deck.id});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewDeck(context, ref);
        },
        child: CachedNetworkImage(
          imageUrl: addDeckIcon,
          height: 40,
          width: 40,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
