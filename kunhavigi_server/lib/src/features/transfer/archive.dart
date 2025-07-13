import 'dart:io';

import 'package:archive/archive.dart';

Future<void> writeZip(Directory dir, File out) async {
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
      final archiveFile = ArchiveFile(archivePath, fileBytes.length, fileBytes);
      archive.addFile(archiveFile);
    } else if (entity is Directory) {
      await _addDirectoryToArchive(archive, entity, archivePath);
    }
  }
}
