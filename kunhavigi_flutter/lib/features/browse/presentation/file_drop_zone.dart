import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/platform/platform.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';

typedef FileDropCallback = void Function(List<FileWithSource> files);

class FileDropZone extends HookConsumerWidget {
  const FileDropZone({
    required this.onFilesDropped,
    required this.child,
    super.key,
  });

  final FileDropCallback onFilesDropped;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragging = useState(false);

    return DropTarget(
      onDragDone: (detail) {
        dragging.value = false;
        final files = detail.files.map(getFiles).expand((e) => e).toList();
        onFilesDropped(files);
      },
      onDragEntered: (detail) {
        dragging.value = true;
      },
      onDragExited: (detail) {
        dragging.value = false;
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !dragging.value,
              child: _FileDropArea(
                isVisible: dragging.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FileDropArea extends ConsumerWidget {
  const _FileDropArea({required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Drop files here to upload',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Drag and drop files from your computer',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
