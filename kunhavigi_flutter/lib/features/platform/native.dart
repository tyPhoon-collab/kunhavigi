import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';

List<FileWithSource> getFiles(XFile item, [String? directory]) {
  return FileSystemEntity.isDirectorySync(item.path)
      ? Directory(item.path)
          .listSync()
          .map(
              (e) => getFiles(XFile(e.path), '${directory ?? ''}${item.name}/'))
          .expand((e) => e)
          .toList()
      : [FileWithSource(file: item, directory: directory)];
}
