import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeToggleIconButton extends ConsumerWidget {
  const ThemeToggleIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = AdaptiveTheme.of(context).mode;
    final icon = switch (themeMode) {
      AdaptiveThemeMode.light => Icons.light_mode_rounded,
      AdaptiveThemeMode.dark => Icons.dark_mode_rounded,
      AdaptiveThemeMode.system => Icons.brightness_6_rounded
    };
    return IconButton(
      icon: Icon(icon),
      tooltip: 'Toggle theme',
      onPressed: () {
        AdaptiveTheme.of(context).toggleThemeMode();
      },
    );
  }
}
