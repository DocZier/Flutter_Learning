import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData themeData;
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeData,
    required this.themeMode,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}