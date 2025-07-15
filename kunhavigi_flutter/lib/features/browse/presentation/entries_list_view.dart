import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/entry_menu_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/preview_modal.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/messages.dart';
import 'package:kunhavigi_flutter/theme.dart';

typedef EntryCallback = void Function(Entry entry);

class EntriesListView extends ConsumerWidget {
  const EntriesListView({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(currentPathProvider);
    final entries = ref.watch(filteredEntriesProvider(path));

    if (entries.isLoading && !entries.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    if (entries.hasError) {
      final error = entries.error;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ErrorMessage(
          error: switch (error) {
            final NotExistsException e => 'Directory does not exist: ${e.path}',
            final PathOutsideException e =>
              'Path is outside the allowed directory: ${e.path}',
            _ => 'An unexpected error occurred: $error',
          },
          stackTrace: entries.stackTrace,
        ),
      );
    }

    final data = entries.requireValue;

    return data.isRootDirectory
        ? _RootDirectoryListView(data: data, padding: padding, path: path)
        : _SubDirectoryListView(data: data, padding: padding, path: path);
  }
}

class _RootDirectoryListView extends StatelessWidget {
  const _RootDirectoryListView({
    required this.data,
    required this.path,
    this.padding,
  });

  final EntriesResponse data;
  final EdgeInsets? padding;
  final RelativePath path;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey('directory_list_${path.value}'),
      padding: padding,
      itemCount: data.totalCount,
      itemBuilder: (context, index) =>
          _EntryListTile(entry: data.entries[index]),
    );
  }
}

class _SubDirectoryListView extends ConsumerWidget {
  const _SubDirectoryListView({
    required this.data,
    required this.path,
    this.padding,
  });

  final EntriesResponse data;
  final EdgeInsets? padding;
  final RelativePath path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      key: PageStorageKey('directory_list_${path.value}'),
      padding: padding,
      itemCount: data.totalCount + 2,
      itemBuilder: (context, index) {
        return switch (index) {
          0 => _NavigationTile(
              title: 'Go to root directory',
              icon: Icons.home,
              onTap: ref.read(currentPathProvider.notifier).setAsRoot,
            ),
          1 => _NavigationTile(
              title: 'Go to parent directory',
              icon: Icons.arrow_back,
              onTap: ref.read(currentPathProvider.notifier).setAsParent,
            ),
          _ => _EntryListTile(entry: data.entries[index - 2]),
        };
      },
    );
  }
}

const _margin = EdgeInsets.symmetric(horizontal: 16, vertical: 2);

class _EntryListTile extends ConsumerWidget {
  const _EntryListTile({
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final (:backgroundColor, :iconColor, :icon) = entry.presentation(context);

    void showPreviewModal() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => PreviewModal(entry: entry),
      );
    }

    void navigate() {
      ref.read(currentPathProvider.notifier).setPath(entry.path);
    }

    return Padding(
      padding: _margin,
      child: Tooltip(
        message: entry.tooltip(),
        waitDuration: const Duration(milliseconds: 500),
        child: ListTile(
          title: Text(
            entry.name,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: switch (entry) {
            final FileEntry fileEntry => Text(
                fileEntry.size.toByteString(),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            final DirectoryEntry _ => null,
            final UnknownEntry _ => null,
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: shape.copyWith(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          trailing: EntryMenuButton(entry: entry),
          onTap: switch (entry) {
            FileEntry() => showPreviewModal,
            DirectoryEntry() => navigate,
            UnknownEntry() => () {},
          },
          shape: shape,
          tileColor: colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}

class _NavigationTile extends StatelessWidget {
  const _NavigationTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final foregroundColor = colorScheme.onSecondaryContainer;
    final backgroundColor = colorScheme.secondaryContainer;

    return Padding(
      padding: _margin,
      child: ListTile(
        title: Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(icon, color: foregroundColor),
        tileColor: backgroundColor,
        onTap: onTap,
        shape: shape,
      ),
    );
  }
}

extension on Entry {
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
