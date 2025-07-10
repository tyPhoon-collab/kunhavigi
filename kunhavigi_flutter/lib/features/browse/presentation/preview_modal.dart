import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/common/presentation/bottom_sheet_base.dart';
import 'package:kunhavigi_flutter/features/common/presentation/messages.dart';

class PreviewModal extends StatelessWidget {
  const PreviewModal({required this.entry, super.key});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      header: BottomSheetHeader(
        title: entry.name,
        subtitle: entry.path.value,
        icon: switch (entry) {
          final FileEntry _ => Icons.insert_drive_file,
          final DirectoryEntry _ => Icons.folder,
          final UnknownEntry _ => Icons.question_mark,
        },
      ),
      child: _Preview(path: entry.path),
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
