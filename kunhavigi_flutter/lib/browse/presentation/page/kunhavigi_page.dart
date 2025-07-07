import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/presentation/entries_list_view.dart';
import 'package:kunhavigi_flutter/browse/presentation/file_drop_zone.dart';
import 'package:kunhavigi_flutter/browse/presentation/upload_button.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/common/presentation/messages.dart';
import 'package:kunhavigi_flutter/common/provider/use_case_provider.dart';

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return FileDropZone(
      onFilesDropped: (List<DropItemFile> files) async {
        final currentPath = ref.read(currentPathProvider);
        // TODO: エラーハンドリング
        await ref.read(dropAndUploadUseCaseProvider).upload(currentPath, files);
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
        body: EntriesListView(
          onFileTap: (entry) {
            _showPreviewModal(context, entry);
          },
        ),
        floatingActionButton: const UploadButton(),
      ),
    );
  }

  void _showPreviewModal(BuildContext context, Entry entry) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PreviewModal(entry: entry),
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
      icon: Icon(Icons.refresh,
          color: colorScheme.onSurface.withValues(alpha: 0.8)),
      onPressed: () {
        ref.invalidate(entriesProvider(currentPath));
      },
      tooltip: 'Reload',
    );
  }
}

class _PreviewModal extends StatelessWidget {
  const _PreviewModal({required this.entry});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              _PreviewHeader(entry: entry),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _Preview(path: entry.path),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({required this.entry});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Icon(
            switch (entry) {
              final FileEntry _ => Icons.insert_drive_file,
              final DirectoryEntry _ => Icons.folder,
              final UnknownEntry _ => Icons.question_mark,
            },
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  entry.path.value,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

class _Preview extends ConsumerWidget {
  const _Preview({required this.path});

  final RelativePath path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final preview = ref.watch(entryPreviewProvider(path));

    return preview.when(
      data: (data) => _PreviewContent(data: data),
      loading: () => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: CircularProgressIndicator(
            color: colorScheme.primary,
          ),
        ),
      ),
      error: (error, stack) => ErrorMessage(
        error: error,
        stackTrace: stack,
      ),
    );
  }
}

class _PreviewContent extends StatelessWidget {
  const _PreviewContent({required this.data});

  final EntryPreview data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return switch (data) {
      final TextEntryPreview text => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: SelectableText(
            text.text,
            style: textTheme.bodyMedium?.copyWith(
              fontFamily: 'monospace',
              color: colorScheme.onSurface,
            ),
          ),
        ),
      final ImageEntryPreview image => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            image.base64,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => ErrorMessage(
              error: 'Failed to load image',
              stackTrace: stackTrace,
            ),
          ),
        ),
      final UnknownEntryPreview _ => const InfoMessage(
          message: 'No preview available for this entry.',
        ),
    };
  }
}
