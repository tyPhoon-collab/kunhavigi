import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/presentation/entries_list_view.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: EntriesListView(
          onFileTap: (entry) {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: _Preview(path: entry.absolutePath),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Preview extends ConsumerWidget {
  const _Preview({required this.path});

  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(entryPreviewProvider(path));
    return preview.when(
      data: (data) => switch (data) {
        final TextEntryPreview text => Text(
            text.text,
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        final ImageEntryPreview image => Image.memory(
            image.base64,
            fit: BoxFit.cover,
          ),
        final UnknownEntryPreview _ =>
          const Text('No preview available for this entry.'),
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
