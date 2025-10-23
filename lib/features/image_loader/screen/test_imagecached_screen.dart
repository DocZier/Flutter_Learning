import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TestImageListScreen extends StatefulWidget {
  const TestImageListScreen({super.key});

  @override
  State<TestImageListScreen> createState() => _TestImageListScreenState();
}

class _TestImageListScreenState extends State<TestImageListScreen> {

  int _currentIndex = 0;
  final List<String> imageURLs = [
    'https://wallpapers.com/images/high/cute-snake-pictures-zdyo5zqedn93fct5.webp',
    'https://wallpapers.com/images/high/cute-snake-pictures-gjd2r1kzawco6y8v.webp',
    'https://wallpapers.com/images/high/cute-snake-pictures-rhpqt2fje54ppspv.webp',
    'https://wallpapers.com/images/high/cute-snake-pictures-ux2hh39umlq1esh5.webp',
    'https://wallpapers.com/images/high/cute-snake-pictures-cy92c37zxua1kp9e.webp',
  ];

  void _decrement() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + imageURLs.length) % imageURLs.length;
    });
  }

  void _increment() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imageURLs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Тестовый экран со змейками')),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton.outlined(
              onPressed: _decrement,
              icon: Icon(Icons.chevron_left_sharp),
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: imageURLs[_currentIndex],
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
                fit: BoxFit.contain,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton.outlined(
              onPressed: _increment,
              icon: Icon(Icons.chevron_right_sharp),
            ),
          ),
        ],
      ),
    );
  }
}