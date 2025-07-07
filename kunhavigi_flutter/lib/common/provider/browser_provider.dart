import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/common/application/browser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'browser_provider.g.dart';

@Riverpod(keepAlive: true)
Browser browser(Ref ref) {
  return Browser(ref);
}
