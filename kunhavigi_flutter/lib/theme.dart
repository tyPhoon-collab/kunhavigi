import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
  );
}
