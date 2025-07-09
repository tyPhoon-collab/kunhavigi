import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/entries_list_view.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/file_drop_zone.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/upload_button.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:kunhavigi_flutter/main.dart';

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return FileDropZone(
      onFilesDropped: (files) async {
        if (files.isEmpty) {
          logger.w('No files dropped');
          return;
        }
        final currentPath = ref.read(currentPathProvider);
        try {
          await ref
              .read(dropAndUploadUseCaseProvider)
              .upload(currentPath, files);
          teller?.success('Files uploaded successfully');
        } on Exception catch (e) {
          teller?.error(e);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kunhavigi'),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(child: _PathBreadcrumb()),
                  _ReloadButton(),
                ],
              ),
            ),
          ),
        ),
        body: const EntriesListView(padding: EdgeInsets.only(bottom: 86)),
        floatingActionButton: const UploadButton(),
      ),
    );
  }
}

class _PathBreadcrumb extends ConsumerWidget {
  const _PathBreadcrumb();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.watch(currentPathProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      currentPath.isRoot ? 'Root Directory' : currentPath.value,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ReloadButton extends ConsumerWidget {
  const _ReloadButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final currentPath = ref.watch(currentPathProvider);

    return IconButton(
      icon: Icon(
        Icons.refresh,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      onPressed: () => ref.invalidate(entriesProvider(currentPath)),
      tooltip: 'Reload',
    );
  }
}
