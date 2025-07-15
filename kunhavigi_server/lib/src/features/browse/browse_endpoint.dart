import 'dart:io';

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

  /// Search entries (files and directories) by name under a given path, or globally if path is null.
  Future<EntriesResponse> searchEntries(
    Session session,
    String query, {
    RelativePath? path,
  }) async {
    final dir = path != null
        ? exactDirectory(validateAndNormalizePath(path))
        : Directory(dataDirectoryPath.value);
    final entries = dir
        .listSync(recursive: true)
        .where((entity) => p.basename(entity.path).contains(query))
        .map(buildEntry)
        .toList();

    final place = path?.value ?? 'root';
    session.log(
        'Searched ${entries.length} entries in $place with query "$query"');

    return EntriesResponse(
      entries: entries,
      totalCount: entries.length,
      isRootDirectory: isRootDirectory(path),
    );
  }

  /// Get the list of entries (files and directories) in a given path.
  Future<EntriesResponse> getEntries(
    Session session,
    RelativePath path,
  ) async {
    final normalizedPath = validateAndNormalizePath(path);

    final dir = exactDirectory(normalizedPath);

    final entries = dir.listSync().map(buildEntry).toList();

    session.log('Listed ${entries.length} entries in ${path.value}');

    return EntriesResponse(
      entries: entries,
      totalCount: entries.length,
      isRootDirectory: isRootDirectory(path),
    );
  }

  /// Peek at the content of a file to generate a preview.
  Future<EntryPreview> peekEntry(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);
    final mimeFile = exactMimeFile(normalizedPath);

    final preview = switch (mimeFile) {
      final TextMimeFile file => await _textPreviewGenerator.generate(file),
      final ImageMimeFile file => await _imagePreviewGenerator.generate(file),
      _ => const EntryPreview.unknown(),
    };

    final title = '${preview.runtimeType}(${mimeFile.mimeType})';
    session.log('Generated $title preview for ${path.value}');

    return preview;
  }

  /// Delete a file from the server
  Future<bool> delete(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);
    final file = exactEntity(normalizedPath);

    try {
      await file.delete(recursive: true);
      session.log('Deleted ${path.value}');
      return true;
    } on Exception catch (e) {
      session.log(
        'Failed to delete ${path.value}: $e',
        level: LogLevel.error,
        exception: e,
      );
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

    try {
      file.renameSync(p.join(file.parent.path, newName));
      final entry = buildEntry(file);
      session.log('Renamed ${path.value} to $newName');
      return entry;
    } on Exception catch (e) {
      session.log(
        'Failed to rename ${path.value} to $newName: $e',
        level: LogLevel.error,
        exception: e,
      );
      rethrow;
    }
  }
}
