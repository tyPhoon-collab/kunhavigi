import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/client.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentPath extends _$CurrentPath {
  @override
  RelativePath build() {
    return const RelativePath.root();
  }

  void setPath(RelativePath path) {
    logInfo('Navigating to path: $path');
    state = path;
  }

  void setAsRoot() {
    logInfo('Navigating to root directory');
    state = const RelativePath.root();
  }

  void setAsParent() {
    if (state.isRoot) return;
    final segments = state.segments();
    if (segments.length <= 1) {
      state = const RelativePath.root();
    } else {
      state = state.parent;
    }
    logInfo('Navigating to parent directory: $state');
  }
}

@Riverpod(keepAlive: true)
Future<EntriesResponse> entries(
  Ref ref,
  RelativePath path,
) async {
  logInfo('Fetching entries for path: $path');
  try {
    final client = ref.watch(clientProvider);
    final result = await client.browse.getEntries(path);
    logInfo('Successfully fetched ${result.entries.length} entries');
    return result;
  } catch (error, stackTrace) {
    logError('Failed to fetch entries for path: $path', error, stackTrace);
    rethrow;
  }
}

@Riverpod(keepAlive: true)
Future<EntryPreview> entryPreview(
  Ref ref,
  RelativePath path,
) async {
  logInfo('Fetching preview for path: $path');
  try {
    final client = ref.watch(clientProvider);
    final result = await client.browse.peekEntry(path);
    logInfo('Successfully fetched preview for: $path');
    return result;
  } catch (error, stackTrace) {
    logError('Failed to fetch preview for path: $path', error, stackTrace);
    rethrow;
  }
}
