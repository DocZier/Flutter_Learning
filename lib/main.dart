import 'package:flutter/material.dart';
import 'package:test_practic/features/deck/screens/deck_list_screen.dart';
import 'package:test_practic/state/data_container.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreenWrapper(appData: appData),
    );
  }
}