import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kunhavigi_page.g.dart';

@riverpod
Future<List<Entry>> entries(
  Ref ref,
  String path,
) async {
  final client = ref.watch(clientProvider);
  return client.browse.getEntries(path);
}

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final entries = ref.watch(entriesProvider(''));

    return Scaffold(
      body: Center(
        child: entries.when(
          data: (entries) {
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text(entry.name),
                  subtitle: Text(entry.path),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text(
              switch (error) {
                final NotExistsException e =>
                  'Directory does not exist: ${e.path}',
                final PathOutsideException e =>
                  'Path is outside the allowed directory: ${e.path}',
                _ => 'An unexpected error occurred: $error',
              },
              style: TextStyle(color: colorScheme.error),
            );
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
