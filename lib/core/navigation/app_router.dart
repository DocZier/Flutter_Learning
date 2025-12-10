import 'package:go_router/go_router.dart';
import 'package:test_practic/features/auth/presentation/screens/login_screen.dart';
import 'package:test_practic/features/auth/presentation/screens/register_screen.dart';
import 'package:test_practic/features/dictionary/presentation/screens/detail_screen.dart';
import 'package:test_practic/features/flashcards/presentation/screens/deck/deck_detail_screen.dart';
import 'package:test_practic/features/flashcards/presentation/screens/deck/deck_list_screen.dart';
import 'package:test_practic/features/flashcards/presentation/screens/flashcard/add_flashcard_screen.dart';
import 'package:test_practic/features/flashcards/presentation/screens/flashcard/study_screen.dart';
import 'package:test_practic/features/profile/presentation/screens/profile_screen.dart';
import 'package:test_practic/features/settings/presentation/screens/settings_screen.dart';
import 'package:test_practic/features/stats/presentation/screen/stats_screen.dart';
import '../../features/dictionary/presentation/screens/search_screen.dart';
import '../../features/flashcards/presentation/screens/statistic/statistic_screen.dart';
import '../../features/lessons/presentation/screens/lesson_screen.dart';
import '../../features/lessons/presentation/screens/lessons_list_screen.dart';
import '../../features/lessons/presentation/screens/test_screen.dart';
import '../../menu/menu_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) {
          return ProfileScreen();
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) {
          return SearchScreen();
        },
      ),
      GoRoute(
        path: '/lessons',
        name: 'lessons',
        builder: (context, state) {
          return LessonsListScreen();
        },
      ),
      GoRoute(
        path: '/lesson',
        name: 'lesson',
        builder: (context, state) {
          final lessonId = state.extra as Map<String, dynamic>;
          return LessonScreen(lessonId: lessonId['id']);
        },
      ),
      GoRoute(
          path: '/test',
          name: 'test',
          builder: (context, state) {
            final lessonId = state.extra as Map<String, dynamic>;
            return TestScreen(lessonId: lessonId['id']);
          }),
      GoRoute(
        path: '/word',
        name: 'word',
        builder: (context, state) {
          final wordId = state.extra as Map<String, dynamic>;
          return WordDetailScreen(wordId: wordId['wordId']);
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return RegistrationScreen();
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) {
          return SettingsScreen();
        },
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) {
          return MenuScreen();
        },
      ),
      GoRoute(
        path: '/stats',
        name: 'stats',
        builder: (context, state) {
          return StatisticsScreen();
        },
      ),
      GoRoute(
        path: '/add_flashcard',
        name: 'add_flashcard',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return AddCardScreen(currentDeck: deckId['deckId']);
        },
      ),
      GoRoute(
        path: '/study',
        name: 'study',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return StudyScreen(currentDeck: deckId['deckId']);
        },
      ),
      GoRoute(
        path: '/deck_detail',
        name: 'deck_detail',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return DeckDetailsScreen(currentDeck: deckId['deckId']);
        },
      ),
      GoRoute(
        path: '/deck_stats',
        name: 'deck_stats',
        builder: (context, state) {
          final deckId = state.extra as Map<String, dynamic>;
          return DeckStatisticsScreen(currentDeck: deckId['deckId']);
        },
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
