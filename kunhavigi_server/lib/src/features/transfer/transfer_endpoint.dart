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

  // TODO: メモリ効率の改善
  /// Create a zip file from a directory
  Future<FileEntry> createZip(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);
    final directory = exactDirectory(normalizedPath);

    final zipFile =
        File('${getTemporaryDirectory().path}/${const Uuid().v4()}.zip');

    final archive = Archive();
    await _addDirectoryToArchive(archive, directory, '');

    final zipData = ZipEncoder().encode(archive);

    // Create the zip file
    final randomAccessFile = await zipFile.open(mode: FileMode.write);
    try {
      await randomAccessFile.writeFrom(zipData);
      await randomAccessFile.close();
    } catch (e) {
      await randomAccessFile.close();
      if (zipFile.existsSync()) {
        await zipFile.delete();
      }
      rethrow;
    }
    return buildEntry(zipFile) as FileEntry;
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
