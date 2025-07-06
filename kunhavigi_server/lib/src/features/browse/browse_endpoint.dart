import 'dart:io';

import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  late final String dataDirectory = Platform.environment['DATA_DIRECTORY'] ??
      '/Users/hiroaki/projects/kunhavigi/data';

  Future<List<Entry>> getEntries(Session session, String relativePath) async {
    final dirPath = p.join(dataDirectory, relativePath);
    final normalizedPath = p.normalize(dirPath);

    // Ensure the resolved path is within the data directory
    if (!normalizedPath.startsWith(p.normalize(dataDirectory))) {
      throw PathOutsideException(path: normalizedPath);
    }

    final dir = Directory(normalizedPath);

    if (!dir.existsSync()) {
      throw NotExistException(path: dir.path);
    }

    return dir.list().map((entity) {
      final name = p.basename(entity.path);
      final stat = entity.statSync();
      return switch (stat.type) {
        FileSystemEntityType.file => Entry.file(
            name: name,
            path: entity.path,
            size: stat.size,
            lastModifiedAt: stat.modified,
          ),
        FileSystemEntityType.directory => Entry.directory(
            name: name,
            path: entity.path,
          ),
        _ => Entry.unknown(
            name: name,
            path: entity.path,
          ),
      };
    }).toList();
  }
}
