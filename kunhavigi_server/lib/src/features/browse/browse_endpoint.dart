import 'dart:io';

import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  /// Get the list of entries (files and directories) in a given path.
  /// path is relative or absolute, but must be within the data directory.
  Future<EntriesResponse> getEntries(Session session, String path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final dir = existingDirectory(normalizedPath);

    final entries = dir.listSync().map((entity) {
      final absolutePath = p.normalize(entity.path);
      final relativePath = p.relative(absolutePath, from: dataDirectory);
      final stat = entity.statSync();
      return switch (stat.type) {
        FileSystemEntityType.file => Entry.file(
            absolutePath: absolutePath,
            relativePath: relativePath,
            size: stat.size,
            lastModifiedAt: stat.modified,
            mimeType:
                lookupMimeType(absolutePath) ?? 'application/octet-stream',
          ),
        FileSystemEntityType.directory => Entry.directory(
            absolutePath: absolutePath,
            relativePath: relativePath,
          ),
        _ => Entry.unknown(
            absolutePath: absolutePath,
            relativePath: relativePath,
          ),
      };
    }).toList();

    return EntriesResponse(
      entries: entries,
      totalCount: entries.length,
      isRootDirectory: normalizedPath.value == dataDirectory,
    );
  }

  /// Peek at the content of a file to generate a preview.
  Future<EntryPreview> peekEntry(Session session, String path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = existingFile(normalizedPath);
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
}
