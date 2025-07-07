import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/common/presentation/messages.dart';

class PreviewModal extends StatelessWidget {
  const PreviewModal({required this.entry, super.key});

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
    final preview = ref.watch(entryPreviewProvider(path));

    return preview.when(
      data: (data) => _PreviewContent(data: data),
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
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
