import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';

extension EntryPresentation on Entry {
  ({
    Color backgroundColor,
    Color iconColor,
    IconData icon,
  }) presentation(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return switch (this) {
      final FileEntry _ => (
          backgroundColor: colorScheme.secondaryContainer,
          iconColor: colorScheme.onSecondaryContainer,
          icon: Icons.insert_drive_file,
        ),
      final DirectoryEntry _ => (
          backgroundColor: colorScheme.tertiaryContainer,
          iconColor: colorScheme.onTertiaryContainer,
          icon: Icons.folder,
        ),
      final UnknownEntry _ => (
          backgroundColor: colorScheme.errorContainer,
          iconColor: colorScheme.onErrorContainer,
          icon: Icons.question_mark,
        ),
    };
  }

  String tooltip() {
    final format = DateFormat.yMMMd().add_jm().format;

    return switch (this) {
      FileEntry(:final size, :final lastModifiedAt, :final mimeType) =>
        '$mimeType, $size bytes | Modified: ${format(lastModifiedAt)}',
      DirectoryEntry(:final lastModifiedAt) =>
        'Modified: ${format(lastModifiedAt)}',
      UnknownEntry(:final lastModifiedAt) =>
        'Modified: ${format(lastModifiedAt)}',
    };
  }
}
