import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';

class PathBreadcrumb extends ConsumerWidget {
  const PathBreadcrumb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.watch(currentPathProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (currentPath.isRoot) {
      return Text(
        'Root Directory',
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      );
    }

    final segments = currentPath.segments();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _RootSegment(ref: ref),
          for (var i = 0; i < segments.length; i++) ...[
            const _PathSeparator(),
            _PathSegment(
              segment: segments[i],
              isLast: i == segments.length - 1,
              onTap: i == segments.length - 1
                  ? null
                  : () => ref
                      .read(currentPathProvider.notifier)
                      .setPath(RelativePath(segments.take(i + 1).join('/'))),
            ),
          ],
        ],
      ),
    );
  }
}

class _RootSegment extends StatelessWidget {
  const _RootSegment({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => ref.read(currentPathProvider.notifier).setAsRoot(),
      child: Text(
        'Root',
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _PathSeparator extends StatelessWidget {
  const _PathSeparator();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Text(
      ' / ',
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }
}

class _PathSegment extends StatelessWidget {
  const _PathSegment({
    required this.segment,
    required this.isLast,
    this.onTap,
  });

  final String segment;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        segment,
        style: textTheme.bodyMedium?.copyWith(
          color: isLast
              ? colorScheme.onSurface.withValues(alpha: 0.8)
              : colorScheme.primary,
          decoration: isLast ? null : TextDecoration.underline,
        ),
      ),
    );
  }
}
