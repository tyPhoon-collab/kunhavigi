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

    final entries = dir.listSync().map(buildEntry).toList();

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
      'text/markdown' ||
      'text/html' ||
      'text/css' ||
      'text/javascript' ||
      'text/xml' ||
      'application/json' ||
      'application/javascript' ||
      'application/xml' ||
      'application/x-yaml' ||
      'application/yaml' =>
        () {
          final content = file.readAsStringSync();
          const maxLength =
              2000; // Maximum characters to preview for reduced data usage
          final text = content.length > maxLength
              ? '${content.substring(0, maxLength)}\n\n... (truncated, ${content.length - maxLength} more characters)'
              : content;
          return EntryPreview.text(text: text);
        }(),
      'image/png' ||
      'image/jpeg' ||
      'image/jpg' ||
      'image/gif' ||
      'image/webp' ||
      'image/svg+xml' ||
      'image/bmp' ||
      'image/tiff' =>
        EntryPreview.image(base64: file.readAsBytesSync()),
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
    return buildEntry(file);
  }
}
