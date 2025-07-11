import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/dialog.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/main.dart';

List<_EntryMenuItem> _commonMenuItems(Entry entry) {
  return [
    _DownloadEntryMenuItem(entry),
    _RenameEntryMenuItem(entry),
    _DeleteEntryMenuItem(entry),
  ];
}

class FileEntryMenuButton extends StatelessWidget {
  const FileEntryMenuButton({
    required this.fileEntry,
    super.key,
  });

  final FileEntry fileEntry;

  @override
  Widget build(BuildContext context) {
    return _EntryMenuButton(
      menuItems: [
        ..._commonMenuItems(fileEntry),
      ],
    );
  }
}

class DirectoryEntryMenuButton extends StatelessWidget {
  const DirectoryEntryMenuButton({
    required this.directoryEntry,
    super.key,
  });

  final DirectoryEntry directoryEntry;

  @override
  Widget build(BuildContext context) {
    return _EntryMenuButton(
      menuItems: [
        ..._commonMenuItems(directoryEntry),
      ],
    );
  }
}

class _EntryMenuButton extends ConsumerWidget {
  const _EntryMenuButton({
    required this.menuItems,
  });

  final List<_EntryMenuItem> menuItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          icon: Icon(
            Icons.more_vert,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: menuItems.map((item) => item.build(ref)).toList(),
    );
  }
}

abstract interface class _EntryMenuItem {
  MenuItemButton build(WidgetRef ref);
}

class _DownloadEntryMenuItem implements _EntryMenuItem {
  const _DownloadEntryMenuItem(this.entry);

  final Entry entry;

  @override
  MenuItemButton build(WidgetRef ref) {
    Future<void> downloadFile() async {
      try {
        await ref.read(downloadUseCaseProvider).download(entry);
        teller?.success('Downloaded successfully');
      } on Exception catch (e) {
        teller?.error(e);
      }
    }

    return MenuItemButton(
      leadingIcon: const Icon(Icons.file_download),
      onPressed: () async => downloadFile(),
      child: const Text('Download'),
    );
  }
}

class _RenameEntryMenuItem implements _EntryMenuItem {
  const _RenameEntryMenuItem(this.entry);

  final Entry entry;

  @override
  MenuItemButton build(WidgetRef ref) {
    Future<void> showRenameDialog() async {
      final result = await showDialog<String>(
        context: ref.context,
        builder: (context) => RenameDialog(initialName: entry.name),
      );

      if (result != null && result.isNotEmpty && result != entry.name) {
        try {
          await ref.read(renameUseCaseProvider).rename(entry.path, result);
          teller?.success('Renamed successfully');
        } on Exception catch (e) {
          teller?.error(e);
        }
      }
    }

    return MenuItemButton(
      leadingIcon: const Icon(Icons.edit),
      onPressed: () async => showRenameDialog(),
      child: const Text('Rename'),
    );
  }
}

class _DeleteEntryMenuItem implements _EntryMenuItem {
  const _DeleteEntryMenuItem(this.entry);

  final Entry entry;

  @override
  MenuItemButton build(WidgetRef ref) {
    final colorScheme = Theme.of(ref.context).colorScheme;

    Future<void> showDeleteDialog() async {
      final result = await showDialog<bool>(
        context: ref.context,
        builder: (context) => DeleteDialog(name: entry.name),
      );
      if (result ?? false) {
        try {
          await ref.read(deleteUseCaseProvider).delete(entry.path);
          teller?.success('Deleted successfully');
        } on Exception catch (e) {
          teller?.error(e);
        }
      }
    }

    return MenuItemButton(
      leadingIcon: Icon(
        Icons.delete,
        color: colorScheme.error,
      ),
      onPressed: () async => showDeleteDialog(),
      child: Text(
        'Delete',
        style: TextStyle(color: colorScheme.error),
      ),
    );
  }
}
