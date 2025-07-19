import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/core/presentation/teller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teller_provider.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> navigatorKey(Ref ref) {
  return GlobalKey<NavigatorState>();
}

@riverpod
Teller teller(Ref ref) {
  final context = ref.watch(navigatorKeyProvider).currentContext;
  if (context == null) {
    throw StateError('Navigator context is not available');
  }
  return Teller(context);
}
