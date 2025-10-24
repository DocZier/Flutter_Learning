import 'package:flutter/material.dart';
import 'package:test_practic/state/data_container.dart';
import 'package:test_practic/state/flashcard_container.dart';
import 'package:test_practic/navigation/app_router.dart';

void main() {
  AppData appData = AppData();

  runApp(MyApp(appData: appData,));
}

class MyApp extends StatelessWidget {
  final AppData appData;

  const MyApp({
    super.key,
    required this.appData
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter(appData: appData).getRouter(),
    );
  }
}