import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/extension.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/messages.dart';
import 'package:kunhavigi_flutter/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search.g.dart';

@Riverpod(keepAlive: true)
class _SearchQuery extends _$SearchQuery {
  @override
  SearchQuery build() {
    return const SearchQuery(query: '');
  }

  bool hasNextPage(int totalCount) => state.page * state.limit < totalCount;

  bool hasPreviousPage() => state.page > 1;

  void setQuery(String query, {RelativePath? path}) {
    state = state.copyWith(query: query, path: path);
  }

  void nextPage() {
    state = state.nextPage();
  }

  void previousPage() {
    state = state.previousPage();
  }
}

@Riverpod(keepAlive: true)
Future<EntriesResponse> _currentSearchedEntries(Ref ref) async {
  final query = ref.watch(_searchQueryProvider);
  return ref.watch(searchedEntriesProvider(query).future);
}

class EntriesSearchAnchor extends HookConsumerWidget {
  const EntriesSearchAnchor({required this.builder, super.key});

  final SearchAnchorChildBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return SearchAnchor(
      suggestionsBuilder: (context, controller) async {
        return [
          _SearchSuggestion(text: controller.text),
          const _PaginationButtons(),
        ];
      },
      viewBackgroundColor: colorScheme.surfaceContainerLow,
      viewHintText: 'Search files or folders',
      viewShape: shape,
      dividerColor: colorScheme.onSurface.withValues(alpha: 0.2),
      shrinkWrap: true,
      builder: builder,
    );
  }
}

class _SearchSuggestion extends HookConsumerWidget {
  const _SearchSuggestion({required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncedText =
        useDebounced(text, const Duration(milliseconds: 500)) ?? text;

    if (debouncedText.isEmpty) {
      ref.invalidate(_searchQueryProvider);
      return const Padding(
        padding: EdgeInsets.all(8),
        child: InfoMessage(
            message: 'You can search by name. '
                'To search within the current path, start your query with "@"'),
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final set = ref.read(_searchQueryProvider.notifier).setQuery;
        // If the query starts with '@', treat it as a path
        if (debouncedText[0] == '@') {
          final path = ref.read(currentPathProvider);
          set(debouncedText.substring(1), path: path);
        } else {
          set(debouncedText);
        }
      });
      return null;
    }, [debouncedText]);

    final response = ref.watch(_currentSearchedEntriesProvider);

    if (response.isLoading && !response.hasValue) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (response.hasError) {
      final error = response.error;
      return Padding(
        padding: const EdgeInsets.all(8),
        child: ErrorMessage(error: error!, stackTrace: response.stackTrace),
      );
    }

    final totalCount = response.requireValue.totalCount;
    final entries = response.requireValue.entries;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: entries.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return InfoMessage(message: '$totalCount entries found');
        }
        final entry = entries[index - 1];
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
      title: Text(
        entry.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${entry.parent.value}/',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
      ),
      leading: Icon(icon, color: iconColor, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      onTap: () {
        final path = switch (entry) {
          DirectoryEntry() => entry.path,
          FileEntry() || UnknownEntry() => entry.parent,
        };
        ref.read(currentPathProvider.notifier).setPath(path);
      },
      shape: shape,
    );
  }
}

class _PaginationButtons extends ConsumerWidget {
  const _PaginationButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref.watch(_currentSearchedEntriesProvider);
    final query = ref.watch(_searchQueryProvider);

    if (!response.hasValue) {
      return const SizedBox.shrink();
    }

    final value = response.requireValue;

    final totalCount = value.totalCount;
    final currentPage = query.page;
    final totalPages = (totalCount / query.limit).ceil();

    if (totalPages <= 1) {
      return const SizedBox.shrink();
    }

    final notifier = ref.watch(_searchQueryProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: notifier.hasPreviousPage() ? notifier.previousPage : null,
          tooltip: 'Previous Page',
        ),
        Text('$currentPage / $totalPages'),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          onPressed:
              notifier.hasNextPage(totalCount) ? notifier.nextPage : null,
          tooltip: 'Next Page',
        ),
      ],
    );
  }
}
