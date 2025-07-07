import 'dart:io';

import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

Entry createEntry(FileSystemEntity file) {
  final absolutePath = p.normalize(file.path);
  final relativePath = p.relative(absolutePath, from: dataDirectory);
  final stat = file.statSync();
  final mimeType = lookupMimeType(absolutePath) ?? 'application/octet-stream';

  final path = RelativePath(relativePath);

  return switch (stat.type) {
    FileSystemEntityType.file => Entry.file(
        path: path,
        size: stat.size,
        lastModifiedAt: stat.modified,
        mimeType: mimeType,
      ),
    FileSystemEntityType.directory => Entry.directory(
        path: path,
      ),
    _ => Entry.unknown(
        path: path,
      ),
  };
}
