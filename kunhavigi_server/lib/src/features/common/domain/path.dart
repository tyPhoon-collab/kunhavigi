import 'dart:io';

import 'package:kunhavigi_server/src/features/common/domain/mime_file.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

extension type const ValidPath._(String value) {}

final String dataDirectory =
    p.normalize(Platform.environment['DATA_DIRECTORY'] ?? '../data');

ValidPath validateAndNormalizePath(RelativePath path) {
  final normalizedPath = _normalizePath(path);

  // Ensure the resolved path is within the data directory
  if (!normalizedPath.startsWith(p.normalize(dataDirectory))) {
    throw PathOutsideException(path: normalizedPath);
  }

  return ValidPath._(normalizedPath);
}

String _normalizePath(RelativePath path) {
  return p.normalize(p.join(dataDirectory, path.value));
}

FileSystemEntity exactEntity(ValidPath path) {
  final type = FileSystemEntity.typeSync(path.value);
  if (type == FileSystemEntityType.notFound) {
    throw NotExistsException(path: path.value);
  }

  return switch (type) {
    FileSystemEntityType.file => File(path.value),
    FileSystemEntityType.directory => Directory(path.value),
    _ => throw NotExistsException(path: path.value),
  };
}

File exactFile(ValidPath path) {
  final file = exactEntity(path);
  if (file.statSync().type != FileSystemEntityType.file) {
    throw NotFileException(path: path.value);
  }

  return file as File;
}

MimeFile exactMimeFile(ValidPath path) {
  final file = exactFile(path);
  final mimeType = lookupMimeType(path.value);
  return MimeFile.fromMimeType(file, mimeType);
}

Directory exactDirectory(ValidPath path) {
  final dir = exactEntity(path);
  if (dir.statSync().type != FileSystemEntityType.directory) {
    throw NotDirectoryException(path: path.value);
  }

  return dir as Directory;
}

Directory getTemporaryDirectory() {
  final tempDir = Directory('$dataDirectory/.kunhavigi/tmp')
    ..createSync(recursive: true);
  return tempDir;
}
