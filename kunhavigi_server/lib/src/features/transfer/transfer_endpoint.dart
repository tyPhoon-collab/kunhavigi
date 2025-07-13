import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  /// Download a file or folder from the server
  Stream<ByteData> downloadFile(Session session, RelativePath path) async* {
    final normalizedPath = validateAndNormalizePath(path);
    final file = exactFile(normalizedPath);
    final fileStream = file.openRead();

    await for (final chunk in fileStream) {
      yield ByteData.sublistView(Uint8List.fromList(chunk));
    }
  }

  /// Get a download URL for a file or folder
  /// Folders are zipped before download
  Future<String> getDownloadUrl(
    Session session,
    RelativePath path,
  ) async {
    final normalizedPath = validateAndNormalizePath(path);
    final entity = exactEntity(normalizedPath);

    final downloadsDir = getDownloadsDirectory();
    final outPath = '${downloadsDir.path}/${const Uuid().v4()}';

    switch (entity) {
      case final File file:
        await file.copy(outPath);
      case final Directory dir:
        final zipFile = File(outPath);
        await _writeZip(dir, zipFile);
      default:
        throw UnsupportedError('Unsupported entity type for download');
    }

    final uri = (session as MethodCallSession).uri;
    final baseUrl = '${uri.scheme}://${uri.host}:8082';
    return getDownloadUrlFromPath(baseUrl, outPath);
  }

  Future<void> _writeZip(Directory dir, File out) async {
    final archive = Archive();
    await _addDirectoryToArchive(archive, dir, '');

    final zipData = ZipEncoder().encode(archive);

    await out.writeAsBytes(zipData);
  }

  /// Recursively add directory contents to archive
  Future<void> _addDirectoryToArchive(
    Archive archive,
    Directory directory,
    String basePath,
  ) async {
    await for (final entity in directory.list()) {
      final relativePath = entity.path.substring(directory.path.length + 1);
      final archivePath =
          basePath.isEmpty ? relativePath : '$basePath/$relativePath';

      if (entity is File) {
        final fileBytes = await entity.readAsBytes();
        final archiveFile =
            ArchiveFile(archivePath, fileBytes.length, fileBytes);
        archive.addFile(archiveFile);
      } else if (entity is Directory) {
        await _addDirectoryToArchive(archive, entity, archivePath);
      }
    }
  }

  /// Upload a file to the server
  Future<Entry> uploadFile(
    Session session, {
    required RelativePath path,
    required Stream<ByteData> data,
  }) async {
    final normalizedPath = validateAndNormalizePath(path);
    final file = File(normalizedPath.value);

    // Ensure the directory exists
    await file.parent.create(recursive: true);

    final randomAccessFile = await file.open(mode: FileMode.write);

    try {
      await for (final byteData in data) {
        await randomAccessFile.writeFrom(byteData.buffer.asUint8List());
      }
      await randomAccessFile.close();
    } catch (e) {
      await randomAccessFile.close();
      if (file.existsSync()) {
        await file.delete();
      }
      rethrow;
    }

    return buildEntry(file);
  }
}
