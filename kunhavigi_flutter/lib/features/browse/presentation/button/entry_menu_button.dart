import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/dialog.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/main.dart';

class EntryMenuButton extends ConsumerWidget {
  const EntryMenuButton({
    required this.entry,
    super.key,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> download() async {
      await ref.read(downloadUseCaseProvider).download(entry);
    }

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
          teller?.errorOf(e);
        }
      }
    }

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
          teller?.errorOf(e);
        }
      }
    }

    return MenuAnchor(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: controller.isOpen ? controller.close : controller.open,
          child: const Icon(Icons.more_vert),
        );
      },
      menuChildren: [
        _EntryMenuItemButton(
          icon: Icons.file_download,
          onPressed: download,
          label: 'Download',
        ),
        _EntryMenuItemButton(
          icon: Icons.edit,
          onPressed: showRenameDialog,
          label: 'Rename',
        ),
        _EntryMenuItemButton(
          icon: Icons.delete,
          onPressed: showDeleteDialog,
          label: 'Delete',
          color: Theme.of(context).colorScheme.error,
        ),
      ],
    );
  }
}

class _EntryMenuItemButton extends StatelessWidget {
  const _EntryMenuItemButton({
    required this.icon,
    required this.onPressed,
    required this.label,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: MenuItemButton(
        // [flutter - Hovering over menu items on a ListTile highlights the list item that contains it and does not go away - Stack Overflow](https://stackoverflow.com/questions/78078512/hovering-over-menu-items-on-a-listtile-highlights-the-list-item-that-contains-it)
        requestFocusOnHover: false,
        leadingIcon: Icon(icon, color: color),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: color)),
      ),
    );
  }
}
