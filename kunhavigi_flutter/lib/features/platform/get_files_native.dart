import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';

List<FileWithSource> getFiles(DropItem item, [String? directory]) {
  return switch (item) {
    final DropItemFile file => switch (FileSystemEntity.typeSync(file.path)) {
        FileSystemEntityType.directory => Directory(file.path)
            .listSync()
            .whereType<File>()
            .map((e) => FileWithSource(
                  file: XFile(e.path),
                  directory: '${directory ?? ''}${file.name}/',
                ))
            .toList(),
        _ => [
            FileWithSource(
              file: file,
              directory: directory,
            )
          ],
      },
    _ => throw ArgumentError(
        'Unsupported drop item type: ${item.runtimeType}',
      ),
  };
}
