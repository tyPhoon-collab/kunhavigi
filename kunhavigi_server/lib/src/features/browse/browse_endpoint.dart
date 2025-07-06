import 'dart:io';

import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  late final String _dataDirectory = p.normalize(
      Platform.environment['DATA_DIRECTORY'] ??
          '/Users/hiroaki/projects/kunhavigi/data');

  /// 相対パスと絶対パスを許容する
  Future<EntriesResponse> getEntries(Session session, String path) async {
    final normalizedPath = _normalizePath(path);

    // Ensure the resolved path is within the data directory
    if (!normalizedPath.startsWith(p.normalize(_dataDirectory))) {
      throw PathOutsideException(path: normalizedPath);
    }

    final dir = Directory(normalizedPath);

    if (!dir.existsSync()) {
      throw NotExistsException(path: dir.path);
    }

    final entries = dir.listSync().map((entity) {
      final absolutePath = p.normalize(entity.path);
      final relativePath = p.relative(absolutePath, from: _dataDirectory);
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
      isRootDirectory: normalizedPath == _dataDirectory,
    );
  }

  /// プレビュー
  Future<EntryPreview> peekEntry(Session session, String path) async {
    final normalizedPath = _normalizePath(path);

    final file = File(normalizedPath);
    if (!file.existsSync()) {
      throw NotExistsException(path: normalizedPath);
    }

    if (file.statSync().type != FileSystemEntityType.file) {
      throw NotFileException(path: normalizedPath);
    }

    final mimeType = lookupMimeType(normalizedPath);

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

  String _normalizePath(String path) {
    return p.isAbsolute(path)
        ? p.normalize(path)
        : p.normalize(p.join(_dataDirectory, path));
  }
}
