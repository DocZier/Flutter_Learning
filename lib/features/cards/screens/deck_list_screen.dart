import 'package:flutter/material.dart';
import 'package:test_practic/features/cards/models/decks.dart';
import 'package:test_practic/features/cards/widgets/deck_view.dart';

class HomeScreen extends StatelessWidget {
  final List<Deck> decks;
  final void Function() onTap;

  const HomeScreen({
    super.key,
    required this.decks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Колоды')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DeckView(
              context,
              decks
            )
          ],
        ),
      ),
    );
  }
}