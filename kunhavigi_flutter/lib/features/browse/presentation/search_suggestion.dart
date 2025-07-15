import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/extension.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/messages.dart';
import 'package:kunhavigi_flutter/theme.dart';

class SearchSuggestion extends HookConsumerWidget {
  const SearchSuggestion({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncedText =
        useDebounced(text, const Duration(milliseconds: 500)) ?? text;

    if (debouncedText.isEmpty) {
      return const Center(child: InfoMessage(message: 'Type to search...'));
    }

    final response =
        ref.watch(searchedEntriesProvider(SearchQuery(query: debouncedText)));

    if (response.isLoading || !response.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    if (response.hasError) {
      final error = response.error;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ErrorMessage(error: error!, stackTrace: response.stackTrace),
      );
    }

    final entries = response.requireValue.entries;

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: entries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return _SearchedEntryListTile(entry);
      },
    );
  }
}

class _SearchedEntryListTile extends ConsumerWidget {
  const _SearchedEntryListTile(this.entry);

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (:backgroundColor, :iconColor, :icon) = entry.presentation(context);

    return ListTile(
      dense: true,
      title: Text(entry.name, overflow: TextOverflow.ellipsis),
      leading: Icon(icon, color: iconColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      onTap: () {
        final path = switch (entry) {
          DirectoryEntry() => entry.path,
          FileEntry() || UnknownEntry() => entry.parent,
        };
        ref.read(currentPathProvider.notifier).setPath(path);
      },
      shape: shape,
      tileColor: backgroundColor,
    );
  }
}
