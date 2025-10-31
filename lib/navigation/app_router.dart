import 'package:go_router/go_router.dart';
import 'package:test_practic/features/deck/screens/deck_detail_screen.dart';
import 'package:test_practic/features/deck/screens/deck_list_screen.dart';
import 'package:test_practic/features/flashcard/screens/add_flashcard_screen.dart';
import 'package:test_practic/features/flashcard/screens/study_screen.dart';
import 'package:test_practic/features/statistic/screen/statistic_screen.dart';
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
      GoRoute(
        path: '/study',
        name: 'study',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return StudyScreen(appData: appData, currentDeck: deckId['deckId']);
        },
      ),
      GoRoute(
        path: '/deck_detail',
        name: 'deck_detail',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return DeckDetailsScreenWrapper(appData: appData, currentDeck: deckId['deckId']);
        },
      ),
      GoRoute(
        path: '/deck_stats',
        name: 'deck_stats',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return DeckStatisticsScreen(appData: appData, currentDeck: deckId['deckId']);
        },
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
