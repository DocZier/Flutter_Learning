import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_practic/state/data_container.dart';
import 'package:test_practic/navigation/app_router.dart';
import 'package:test_practic/state/data_repository.dart';

void main() {
  GetIt.I.registerSingleton<AppData>(
    AppData(),
    signalsReady: true,
  );

  GetIt.I.registerSingleton<AppDataRepository>(
    AppDataRepositoryImpl(appData: GetIt.I<AppData>()),
    signalsReady: true,
  );
  
  runApp(MyApp());
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
