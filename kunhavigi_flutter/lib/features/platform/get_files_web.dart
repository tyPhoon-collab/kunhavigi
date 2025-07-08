import 'package:desktop_drop/desktop_drop.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';

List<FileWithSource> getFiles(DropItem item, [String? directory]) {
  return switch (item) {
    final DropItemFile file => [
        FileWithSource(
          file: file,
          directory: directory,
        )
      ],
    final DropItemDirectory dir => dir.children
        .map((child) => getFiles(child, '${directory ?? ''}${dir.name}/'))
        .expand((e) => e)
        .toList(),
    _ => throw ArgumentError(
        'Unsupported drop item type: ${item.runtimeType}',
      ),
  };
}
