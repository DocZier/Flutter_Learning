import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/models/decks.dart';
import 'package:test_practic/state/data_container.dart';
import 'package:test_practic/features/deck/widgets/deck_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../state/data_provider.dart';
import '../../../state/data_repository.dart';
import '../../flashcard/screens/study_screen.dart';
import 'deck_detail_screen.dart';

const deckIcon = 'https://cdn-icons-png.flaticon.com/512/17554/17554945.png';
const emptyListIcon =
    'https://cdn-icons-png.flaticon.com/512/18895/18895859.png';
const addDeckIcon = 'https://cdn-icons-png.flaticon.com/512/2311/2311991.png';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _createNewDeck(BuildContext context, void Function(Deck deck) addDeck) {
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
            onPressed: () => {
              context.pop()
            },
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (deckName.isNotEmpty) {
                setState(() {
                  addDeck(
                    Deck(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: deckName,
                      description: deckDescription,
                      flashcards: [],
                    ),
                  );
                });
              }
              context.pop();
            },
            child: Text('Создать'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appData = AppDataLogic.of(context).appData;

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
      body: appData.isEmpty()
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
              itemCount: appData.getLength(),
              itemBuilder: (_, index) {
                final deck =  appData.getDeckByIndex(index);
                return DeckListItem(
                  deck: deck,
                  onTapEmpty: (test) {
                    Router.neglect(context, () {
                      context.go('/add_flashcard', extra: {'deckId': deck.id});
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
        onPressed: ()  {
          _createNewDeck(context,  AppDataLogic.of(context).appDataRepository.addDeck);
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
