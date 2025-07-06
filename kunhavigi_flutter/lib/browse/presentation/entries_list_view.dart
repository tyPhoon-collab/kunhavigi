import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/common/presentation/messages.dart';

typedef EntryCallback = void Function(Entry entry);

class EntriesListView extends ConsumerWidget {
  const EntriesListView({
    super.key,
    this.onFileTap,
  });

  final EntryCallback? onFileTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final path = ref.watch(pathProvider);
    final entries = ref.watch(entriesProvider(path));

    return entries.when(
      loading: () => Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
        ),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(16),
        child: ErrorMessage(
          error: switch (error) {
            final NotExistsException e => 'Directory does not exist: ${e.path}',
            final PathOutsideException e =>
              'Path is outside the allowed directory: ${e.path}',
            _ => 'An unexpected error occurred: $error',
          },
          stackTrace: stackTrace,
        ),
      ),
      data: (data) => _EntriesListViewContent(
        data: data,
        onFileTap: onFileTap,
      ),
    );
  }
}

class _EntriesListViewContent extends ConsumerWidget {
  const _EntriesListViewContent({
    required this.data,
    required this.onFileTap,
  });

  final EntriesResponse data;
  final EntryCallback? onFileTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!data.isRootDirectory) {
      return ListView.builder(
        itemCount: data.totalCount + 2,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => _NavigationTile(
                title: 'Go to root directory',
                icon: Icons.home,
                onTap: () {
                  ref.read(pathProvider.notifier).setAsRoot();
                },
              ),
            1 => _NavigationTile(
                title: 'Go to parent directory',
                icon: Icons.arrow_back,
                onTap: () {
                  ref.read(pathProvider.notifier).setAsParent();
                },
              ),
            _ => _EntryListTile(
                entry: data.entries[index - 2],
                onFileTap: onFileTap,
              ),
          };
        },
      );
    }

    return ListView.builder(
      itemCount: data.totalCount,
      itemBuilder: (context, index) {
        final entry = data.entries[index];
        return _EntryListTile(
          entry: entry,
          onFileTap: onFileTap,
        );
      },
    );
  }
}

class _EntryListTile extends ConsumerWidget {
  const _EntryListTile({
    required this.entry,
    this.onFileTap,
  });

  final EntryCallback? onFileTap;
  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    void navigate(String path) {
      ref.read(pathProvider.notifier).setPath(path);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        title: Text(
          entry.name,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          entry.absolutePath,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getIconBackgroundColor(colorScheme),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            switch (entry) {
              final FileEntry _ => Icons.insert_drive_file,
              final DirectoryEntry _ => Icons.folder,
              final UnknownEntry _ => Icons.question_mark,
            },
            color: _getIconColor(colorScheme),
            size: 20,
          ),
        ),
        onTap: () {
          switch (entry) {
            case final FileEntry _:
              onFileTap?.call(entry);
            case final DirectoryEntry _:
              navigate(entry.absolutePath);
            case final UnknownEntry _:
              break;
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color _getIconBackgroundColor(ColorScheme colorScheme) {
    return switch (entry) {
      final FileEntry _ => colorScheme.secondaryContainer,
      final DirectoryEntry _ => colorScheme.tertiaryContainer,
      final UnknownEntry _ => colorScheme.errorContainer,
    };
  }

  Color _getIconColor(ColorScheme colorScheme) {
    return switch (entry) {
      final FileEntry _ => colorScheme.onSecondaryContainer,
      final DirectoryEntry _ => colorScheme.onTertiaryContainer,
      final UnknownEntry _ => colorScheme.onErrorContainer,
    };
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          icon,
          color: colorScheme.onPrimaryContainer,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
