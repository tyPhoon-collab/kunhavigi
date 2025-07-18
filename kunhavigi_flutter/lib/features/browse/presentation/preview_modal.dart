import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/bottom_sheet_base.dart';
import 'package:kunhavigi_flutter/features/core/presentation/messages.dart';
import 'package:kunhavigi_flutter/features/theme/theme.dart';

class PreviewModal extends StatelessWidget {
  const PreviewModal({required this.entry, super.key});

  final FileEntry entry;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBase(
      header: BottomSheetHeader(
        title: entry.name,
        subtitle: entry.path.value,
        icon: Icons.insert_drive_file,
      ),
      child: _Preview(path: entry.path, mimeType: entry.mimeType),
    );
  }
}

class _Preview extends ConsumerWidget {
  const _Preview({required this.path, required this.mimeType});

  final RelativePath path;
  final String mimeType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(entryPreviewProvider(path));

    return preview.when(
      data: (data) => _PreviewContent(data: data, mimeType: mimeType),
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
  const _PreviewContent({required this.data, required this.mimeType});

  final EntryPreview data;
  final String mimeType;

  @override
  Widget build(BuildContext context) {
    return switch (data) {
      final TextEntryPreview text => _TextView(
          text: text.text,
          initialIsRich: mimeType == 'text/markdown',
        ),
      final ImageEntryPreview image => _ImageView(image: image.base64),
      final VideoEntryPreview video => _ImageView(image: video.base64),
      final UnknownEntryPreview _ => const InfoMessage(
          message: 'No preview available for this entry.',
        ),
    };
  }
}

class _TextView extends HookWidget {
  const _TextView({required this.text, required this.initialIsRich});

  final String text;
  final bool initialIsRich;

  @override
  Widget build(BuildContext context) {
    final isRich = useState(initialIsRich);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            const Text('Rich view'),
            Switch(
              value: isRich.value,
              onChanged: (v) => isRich.value = v,
            ),
          ],
        ),
        Flexible(
          child: isRich.value ? GptMarkdown(text) : SelectableText(text),
        ),
      ],
    );
  }
}

class _ImageView extends StatelessWidget {
  const _ImageView({required this.image});

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: Image.memory(
        image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => ErrorMessage(
          error: 'Failed to load image',
          stackTrace: stackTrace,
        ),
      ),
    );
  }
}
