import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/provider/app_data_provider.dart';
import 'package:test_practic/features/flashcards/deck/widgets/deck_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                ref
                    .read(appDataProvider.notifier)
                    .addDeck(
                      Deck(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: deckName,
                        description: deckDescription,
                        flashcards: [],
                      ),
                    );
              }
              context.pop();
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

  Widget _listScreen(BuildContext context, List<Deck> decks) {
    return ListView.builder(
      itemCount: decks.length,
      itemBuilder: (_, index) {
        final deck = decks[index];
        return DeckListItem(
          deck: deck,
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
    final decks = ref.watch(appDataProvider).user!.decks;
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
        ],
      ),
      body: decks.isEmpty ? _emptyScreen() : _listScreen(context, decks),
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
