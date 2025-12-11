import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_practic/core/navigation/app_router.dart';
import 'package:test_practic/shared/providers/auth_provider.dart';
import 'package:test_practic/shared/providers/theme_provider.dart';

import 'core/di/di_module.dart';
import 'features/settings/presentation/provider/settings_provider.dart';

void main() {
  registerModule();

  runApp(
      ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  final _appRouter = AppRouter();

  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider).themeData;

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeData,
      darkTheme: themeData,
      themeMode: ref.watch(themeProvider).themeMode,
      routerConfig: _appRouter.getRouter(),
    );
  }
}
