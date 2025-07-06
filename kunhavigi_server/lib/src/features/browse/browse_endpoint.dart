import 'dart:io';

import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  late final String dataDirectory = Platform.environment['DATA_DIRECTORY'] ??
      '/Users/hiroaki/projects/kunhavigi/data';

  /// 相対パスと絶対パスを許容する
  Future<List<Entry>> getEntries(Session session, String path) async {
    // Handle both absolute and relative paths
    final normalizedPath = p.isAbsolute(path)
        ? p.normalize(path)
        : p.normalize(p.join(dataDirectory, path));

    // Ensure the resolved path is within the data directory
    if (!normalizedPath.startsWith(p.normalize(dataDirectory))) {
      throw PathOutsideException(path: normalizedPath);
    }

    final dir = Directory(normalizedPath);

    if (!dir.existsSync()) {
      throw NotExistsException(path: dir.path);
    }

    return dir.list().map((entity) {
      final absolutePath = p.normalize(entity.path);
      final relativePath = p.relative(absolutePath, from: dataDirectory);
      final stat = entity.statSync();
      return switch (stat.type) {
        FileSystemEntityType.file => Entry.file(
            absolutePath: absolutePath,
            relativePath: relativePath,
            size: stat.size,
            lastModifiedAt: stat.modified,
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
  }
}
