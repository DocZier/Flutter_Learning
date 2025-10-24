import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_practic/features/deck/screens/deck_list_screen.dart';
import 'package:test_practic/features/flashcard/screens/add_flashcard_screen.dart';
import 'package:test_practic/state/data_container.dart';

class AppRouter {
  final AppData appData;

  AppRouter({required this.appData});

  late final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return HomeScreenWrapper(appData: appData);
        },
      ),
      GoRoute(
        path: '/add_flashcard',
        name: 'add_flashcard',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return AddCardScreen(appData: appData, currentDeck: deckId['deckId']);
        },
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
