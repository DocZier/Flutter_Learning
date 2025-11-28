import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/features/flashcards/presentation/widgets/deck/deck_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../shared/providers/auth_provider.dart';
import '../../../../../shared/state/auth_state.dart';
import '../../../data/model/deck_model.dart';
import '../../provider/deck/deck_provider.dart';

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
        title: Text('Новая колода'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckName = value,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => deckDescription = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => {context.pop()}, child: Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (deckName.isNotEmpty) {
                ref.read(deckProvider.notifier)
                    .addDeck(
                      Deck(
                        userId: (ref.read(authProvider) as Authenticated).user.id,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: deckName,
                        description: deckDescription,
                      ),
                    );
              context.pop();
              }
            },
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }

  Widget _emptyScreen() {
    return Center(
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
    );
  }

  Widget _listScreen(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: ref.watch(deckProvider).decks.length,
      itemBuilder: (_, index) {
        final deck = ref.read(deckProvider).decks[index];
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
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckState = ref.watch(deckProvider);

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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.push('/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: ref.read(deckProvider.notifier).isEmpty() ? _emptyScreen() : _listScreen(context, ref),
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
