import 'dart:io';

import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  late final String dataDirectory = Platform.environment['DATA_DIRECTORY'] ??
      '/Users/hiroaki/projects/kunhavigi/data';

  Future<List<Entry>> getEntries(Session session, String relativePath) async {
    final dir = Directory('$dataDirectory/$relativePath');
    if (!dir.existsSync()) {
      throw Exception('Directory does not exist: $dir');
    }

    return dir
        .listSync()
        .map((file) => switch (file.statSync().type) {
              FileSystemEntityType.file => Entry.file(
                  name: file.uri.pathSegments.last,
                  path: file.uri.path,
                  size: file.statSync().size,
                  lastModifiedAt: file.statSync().modified,
                ),
              FileSystemEntityType.directory => Entry.directory(
                  name: file.uri.pathSegments.last,
                  path: file.uri.path,
                ),
              // TODO: Handle symbolic links or other types of entries
              _ => Entry.unknown(
                  name: file.uri.pathSegments.last,
                  path: file.uri.path,
                ),
            })
        .toList();
  }
}
