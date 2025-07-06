import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';

class EntriesListView extends ConsumerWidget {
  const EntriesListView({
    super.key,
  });

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
                onTap: () {
                  ref.read(pathProvider.notifier).setAsRoot();
                },
              ),
            1 => ListTile(
                title: const Text('Go to parent directory'),
                onTap: () {
                  ref.read(pathProvider.notifier).setAsParent();
                },
              ),
            _ => _EntryListTile(entry: data.entries[index - 2]),
          };
        },
      );
    }

    return ListView.builder(
      itemCount: data.totalCount,
      itemBuilder: (context, index) {
        final entry = data.entries[index];
        return _EntryListTile(entry: entry);
      },
    );
  }
}

class _EntryListTile extends ConsumerWidget {
  const _EntryListTile({
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void openPreview() {}

    void navigate(String path) {
      ref.read(pathProvider.notifier).setPath(path);
    }

    return ListTile(
      title: Text(entry.name),
      subtitle: Text(entry.absolutePath),
      onTap: () {
        switch (entry) {
          case final FileEntry _:
            openPreview();
          case final DirectoryEntry _:
            navigate(entry.absolutePath);
          case final UnknownEntry _:
            break;
        }
      },
    );
  }
}
