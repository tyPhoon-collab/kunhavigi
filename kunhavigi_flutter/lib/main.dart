import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/core/provider/teller_provider.dart';
import 'package:kunhavigi_flutter/features/theme/theme.dart';
import 'package:kunhavigi_flutter/kunhavigi_page.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ProviderScope(child: MyApp(savedThemeMode: savedThemeMode)));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);

    return ToastificationWrapper(
      config: const ToastificationConfig(
        maxTitleLines: 5,
      ),
      child: AdaptiveTheme(
        light: buildTheme(Brightness.light),
        dark: buildTheme(Brightness.dark),
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (theme, dartTheme) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Kunhavigi',
          theme: theme,
          darkTheme: dartTheme,
          home: const KunhavigiPage(),
        ),
      ),
    );
  }
}
