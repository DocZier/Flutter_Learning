import 'package:flutter/material.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/features/deck/widgets/deck_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

const deckIcon =
    'https://cdn-icons-png.flaticon.com/512/17554/17554945.png';
const emptyListIcon =
    'https://cdn-icons-png.flaticon.com/512/18895/18895859.png';
const addDeckIcon =
    'https://cdn-icons-png.flaticon.com/512/2311/2311991.png';

class HomeScreen extends StatelessWidget {
  final List<Deck> decks;
  final void Function(String deckId) onTapEmpty;
  final void Function(String deckId) onTapFull;
  final void Function(String deckId) onLongPress;
  final void Function(Deck newDeck) addDeck;

  const HomeScreen({
    super.key,
    required this.decks,
    required this.addDeck,
    required this.onTapEmpty,
    required this.onTapFull,
    required this.onLongPress,
  });

  void _createNewDeck(BuildContext context) {
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (deckName.isNotEmpty) {
                addDeck(
                  Deck(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: deckName,
                    description: deckDescription,
                    flashcards: [],
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: decks.isEmpty
          ? Center(
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
          : ListView.builder(
              itemCount: decks.length,
              itemBuilder: (_, index) {
                final deck = decks[index];
                return DeckListItem(
                  deck: deck,
                  onTapEmpty: onTapEmpty,
                  onTapFull: onTapFull,
                  onLongPress: onLongPress,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_createNewDeck(context)},
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
