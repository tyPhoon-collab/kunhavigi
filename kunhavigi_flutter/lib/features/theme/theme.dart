import 'package:flutter/material.dart';

final shape = RoundedSuperellipseBorder(
  borderRadius: BorderRadius.circular(16),
);

ThemeData buildTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: brightness,
  );

  const buttonTextStyle = TextStyle(
    fontSize: 16,
  );

  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.surfaceContainer,
    buttonTheme: ButtonThemeData(shape: shape),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: shape,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        textStyle: buttonTextStyle,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: shape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary, width: 1.5),
        textStyle: buttonTextStyle,
        padding: const EdgeInsets.symmetric(vertical: 24),
        shape: shape,
      ),
    ),
  );
}
