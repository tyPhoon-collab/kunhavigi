import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

class BrowseEndpoint extends Endpoint {
  /// Search entries (files and directories) by name under a given path, or globally if path is null.
  Future<EntriesResponse> searchEntries(
    Session session,
    SearchQuery query,
  ) async {
    if (query.query.isEmpty) {
      session.log('Search query is empty, returning empty response');
      return EntriesResponse(entries: [], totalCount: 0);
    }

    final dir = query.path != null
        ? exactDirectory(validateAndNormalizePath(query.path!))
        : exactDataDirectory();

    final allEntries = await dir
        .list(recursive: true)
        .where((entity) => p.basename(entity.path).contains(query.query))
        .map(buildEntry)
        .toList();

    final pagedEntries =
        allEntries.skip(query.offset).take(query.limit).toList();

    session.log(
        'Searched ${allEntries.length} entries in ${dir.path} with query "$query"');

    return EntriesResponse(
      entries: pagedEntries,
      totalCount: allEntries.length,
    );
  }

  /// Get the list of entries (files and directories) in a given path.
  Future<EntriesResponse> getEntries(
    Session session,
    RelativePath path,
  ) async {
    final normalizedPath = validateAndNormalizePath(path);

    final dir = exactDirectory(normalizedPath);

    final entries = await dir.list().map(buildEntry).toList();

    session.log('Listed ${entries.length} entries in ${path.value}');

    return EntriesResponse(
      entries: entries,
      totalCount: entries.length,
    );
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
