import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/extension.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/messages.dart';
import 'package:kunhavigi_flutter/features/core/provider/client_provider.dart';
import 'package:kunhavigi_flutter/features/theme/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search.g.dart';

@Riverpod(keepAlive: true)
class _Taker extends _$Taker {
  @override
  StreamController<int> build() {
    final controller = StreamController<int>();
    ref.onDispose(controller.close);
    return controller;
  }
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
        ];
      },
      viewBackgroundColor: colorScheme.surfaceContainerLow,
      viewHintText: 'Search files or folders',
      viewShape: shape,
      viewOnClose: ref.read(_takerProvider).close,
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
    final client = ref.watch(clientProvider);
    final stream = useRef<Stream<SearchedResponse>?>(null);

    final debouncedText =
        useDebounced(text, const Duration(milliseconds: 500)) ?? text;
    final entries = useState(<Entry>[]);
    final hasMore = useState(false);

    if (debouncedText.isEmpty) {
      stream.value = null;
      return const Padding(
        padding: EdgeInsets.all(8),
        child: InfoMessage(
            message: 'You can search by name. '
                'To search within the current path, start your query with "@"'),
      );
    }

    useEffect(() {
      void set(String query, {RelativePath? path}) {
        final takes = ref.refresh(_takerProvider);
        entries.value = [];
        hasMore.value = false;
        stream.value = client.browse
            .searchEntries(SearchQuery(query: query, path: path), takes.stream);
        takes.add(10);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // If the query starts with '@', treat it as a path
        if (debouncedText[0] == '@') {
          set(debouncedText.substring(1), path: ref.read(currentPathProvider));
        } else {
          set(debouncedText);
        }
      });
      return null;
    }, [debouncedText]);

    useOnStreamChange(
      stream.value,
      onData: (data) {
        entries.value = [...entries.value, ...data.entries];
        hasMore.value = data.hasMore;
      },
    );

    final length = entries.value.length;
    final itemCount = hasMore.value
        ? length + 2
        : length + 1; // +2 for summary and load more button

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _SummaryMessage(length: length, hasMore: hasMore.value);
        } else if (index == length + 1) {
          return const _LoadMoreButton();
        }
        final entry = entries.value[index - 1];
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

class _LoadMoreButton extends ConsumerWidget {
  const _LoadMoreButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      label: const Text('Load more'),
      icon: const Icon(Icons.refresh),
      onPressed: () => ref.read(_takerProvider).add(10),
    );
  }
}

class _SummaryMessage extends StatelessWidget {
  const _SummaryMessage({
    required this.length,
    required this.hasMore,
  });

  final int length;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return InfoMessage(message: '$length${hasMore ? '+' : ''} entries found');
  }
}
