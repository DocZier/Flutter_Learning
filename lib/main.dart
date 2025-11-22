import 'package:flutter/material.dart';
import 'package:test_practic/state/flashcard_container.dart';
import 'package:test_practic/features/image_loader/screen/test_imagecached_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FlashcardContainer(),
    );
  }
}
