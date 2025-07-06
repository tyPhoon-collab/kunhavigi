import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/client.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entry_provider.g.dart';

@Riverpod(keepAlive: true)
class Path extends _$Path {
  @override
  String build() {
    return '';
  }

  void setPath(String path) {
    logInfo('Navigating to path: $path');
    state = path;
  }

  void setAsRoot() {
    logInfo('Navigating to root directory');
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
    logInfo('Navigating to parent directory: $state');
  }
}

@Riverpod(keepAlive: true)
Future<EntriesResponse> entries(
  Ref ref,
  String path,
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
  String path,
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

@riverpod
Future<ByteData> file(
  Ref ref,
  String path,
) async {
  logInfo('Downloading file from path: $path');
  try {
    final client = ref.watch(clientProvider);
    final result = await client.transfer.downloadFile(path);
    logInfo('Successfully downloaded file from: $path');
    return result;
  } catch (error, stackTrace) {
    logError('Failed to download file from path: $path', error, stackTrace);
    rethrow;
  }
}
