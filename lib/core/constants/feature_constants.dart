import 'package:flutter/material.dart';

class FeaturesConstants {
  static const List<Map<String, dynamic>> menuFeatures = [
    {'title': 'Словарь', 'icon': Icons.book_outlined, 'route': '/search'},
    {'title': 'Уроки', 'icon': Icons.featured_play_list_outlined, 'route': '/lessons'},
    {
      'title': 'Карточки',
      'icon': Icons.my_library_books_outlined,
      'route': '/decks',
    },
    {'title': 'Статистика', 'icon': Icons.bar_chart, 'route': '/progress'},
    {'title': 'Профиль', 'icon': Icons.person, 'route': '/profile'},
    {'title': 'Настройки', 'icon': Icons.settings, 'route': '/settings'},
  ];
}