import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';

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

    if (entries.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (entries.hasError) {
      return Text(
        switch (entries.error) {
          final NotExistsException e => 'Directory does not exist: ${e.path}',
          final PathOutsideException e =>
            'Path is outside the allowed directory: ${e.path}',
          _ => 'An unexpected error occurred: ${entries.error}',
        },
        style: TextStyle(color: colorScheme.error),
      );
    }

    final data = entries.requireValue;

    if (!data.isRootDirectory) {
      return ListView.builder(
        itemCount: data.totalCount + 2,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => ListTile(
                title: const Text('Go to root directory'),
                leading: const Icon(Icons.home),
                onTap: () {
                  ref.read(pathProvider.notifier).setAsRoot();
                },
              ),
            1 => ListTile(
                title: const Text('Go to parent directory'),
                leading: const Icon(Icons.arrow_back),
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
    void navigate(String path) {
      ref.read(pathProvider.notifier).setPath(path);
    }

    return ListTile(
      title: Text(entry.name),
      subtitle: Text(entry.absolutePath),
      leading: switch (entry) {
        final FileEntry _ => const Icon(Icons.insert_drive_file),
        final DirectoryEntry _ => const Icon(Icons.folder),
        final UnknownEntry _ => const Icon(Icons.question_mark),
      },
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
    );
  }
}
