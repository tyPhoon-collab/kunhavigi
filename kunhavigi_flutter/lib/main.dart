import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/core/presentation/teller.dart';
import 'package:kunhavigi_flutter/kunhavigi_page.dart';

Teller? teller;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kunhavigi',
      home: Builder(builder: (context) {
        teller = Teller(context);

        return const KunhavigiPage();
      }),
    );
  }
}
