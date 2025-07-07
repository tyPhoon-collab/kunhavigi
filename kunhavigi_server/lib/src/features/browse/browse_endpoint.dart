import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  /// Get the list of entries (files and directories) in a given path.
  /// path is relative or absolute, but must be within the data directory.
  Future<EntriesResponse> getEntries(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final dir = exactDirectory(normalizedPath);

    final entries = dir.listSync().map(createEntry).toList();

    return EntriesResponse(
      entries: entries,
      totalCount: entries.length,
      isRootDirectory: normalizedPath.value == dataDirectory,
    );
  }

  /// Peek at the content of a file to generate a preview.
  Future<EntryPreview> peekEntry(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = exactFile(normalizedPath);
    final mimeType = lookupMimeType(normalizedPath.value);

    return switch (mimeType) {
      'text/plain' ||
      'application/json' ||
      'application/x-yaml' =>
        EntryPreview.text(
          text: file.readAsStringSync(),
        ),
      'image/png' || 'image/jpeg' || 'image/gif' => EntryPreview.image(
          base64: file.readAsBytesSync(),
        ),
      _ => const EntryPreview.unknown(), // Unsupported file type for preview
    };
  }

  /// Delete a file from the server
  Future<bool> delete(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = exactEntity(normalizedPath);

    try {
      await file.delete();
      return true;
    } on Exception {
      return false;
    }
  }

  /// Rename a file or directory on the server
  Future<Entry> rename(
    Session session, {
    required RelativePath path,
    required String newName,
  }) async {
    final normalizedPath = validateAndNormalizePath(path);
    final file = exactEntity(normalizedPath);
    file.renameSync(p.join(file.parent.path, newName));
    return createEntry(file);
  }
}
