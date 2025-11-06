import 'package:flutter/material.dart';
import 'package:test_practic/state/data_container.dart';
import 'package:test_practic/navigation/app_router.dart';
import 'package:test_practic/state/data_provider.dart';

void main() {
  runApp(AppDataLogic(appData: AppData(),child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter().getRouter(),
    );
  }
}