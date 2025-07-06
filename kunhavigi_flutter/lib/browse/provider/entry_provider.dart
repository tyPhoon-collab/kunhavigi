import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_provider.g.dart';

@Riverpod(keepAlive: true)
class Path extends _$Path {
  @override
  String build() {
    return '';
  }

  void setPath(String path) {
    state = path;
  }

  void setAsRoot() {
    state = '';
  }

  void setAsParent() {
    if (state.isEmpty) return;
    final segments = state.split('/');
    if (segments.length <= 1) {
      state = '';
    } else {
      segments.removeLast();
      state = segments.join('/');
    }
  }
}

@Riverpod(keepAlive: true)
Future<EntriesResponse> entries(
  Ref ref,
  String path,
) async {
  final client = ref.watch(clientProvider);
  return client.browse.getEntries(path);
}
