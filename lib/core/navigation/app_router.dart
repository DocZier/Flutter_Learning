import 'package:go_router/go_router.dart';
import 'package:test_practic/presentation/features/auth/screens/login_screen.dart';
import 'package:test_practic/presentation/features/auth/screens/register_screen.dart';
import 'package:test_practic/presentation/features/dictionary/screens/detail_screen.dart';
import 'package:test_practic/presentation/features/fllashcards/screens/deck_detail_screen.dart';
import 'package:test_practic/presentation/features/fllashcards/screens/deck_list_screen.dart';
import 'package:test_practic/presentation/features/fllashcards/screens/add_flashcard_screen.dart';
import 'package:test_practic/presentation/features/fllashcards/screens/study_screen.dart';
import 'package:test_practic/presentation/features/profile/screens/profile_screen.dart';
import 'package:test_practic/presentation/features/settings/screens/settings_screen.dart';
import 'package:test_practic/presentation/features/progress/screens/progress_screen.dart';
import '../../presentation/features/dictionary/screens/search_screen.dart';
import '../../presentation/features/fllashcards/screens/statistic_screen.dart';
import '../../presentation/features/lessons/screens/lesson_screen.dart';
import '../../presentation/features/lessons/screens/lessons_list_screen.dart';
import '../../presentation/features/lessons/screens/test_screen.dart';
import '../../presentation/menu/menu_screen.dart';

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
        path: '/decks',
        name: 'decks',
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
        path: '/progress',
        name: 'progress',
        builder: (context, state) {
          return ProgressScreen();
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
