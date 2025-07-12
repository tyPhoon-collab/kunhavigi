import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/mime_file.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/features/preview/entry_preview_generator.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  final _textPreviewGenerator = TextPreviewGenerator();
  final _imagePreviewGenerator = ImagePreviewGenerator();

  /// Get the list of entries (files and directories) in a given path.
  Future<EntriesResponse> getEntries(
    Session session,
    RelativePath path,
  ) async {
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
    final mimeFile = exactMimeFile(normalizedPath);

    return switch (mimeFile) {
      final TextMimeFile file => _textPreviewGenerator.generate(file),
      final ImageMimeFile file => _imagePreviewGenerator.generate(file),
      _ => const EntryPreview.unknown(),
    };
  }

  /// Delete a file from the server
  Future<bool> delete(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = exactEntity(normalizedPath);

    try {
      await file.delete(recursive: true);
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
