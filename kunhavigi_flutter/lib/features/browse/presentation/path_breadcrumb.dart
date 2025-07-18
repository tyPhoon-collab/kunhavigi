import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';

class PathBreadcrumb extends ConsumerWidget {
  const PathBreadcrumb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.watch(currentPathProvider);

    final segments = currentPath.segments();
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        const Icon(Icons.folder_open_rounded, size: 20),
        const SizedBox(width: 4),
        _PathSegment(
          segment: 'Root',
          isLast: currentPath.isRoot,
          onTap: ref.read(currentPathProvider.notifier).setAsRoot,
        ),
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
    );
  }
}

class _PathSeparator extends StatelessWidget {
  const _PathSeparator();

  @override
  Widget build(BuildContext context) {
    return const Text(' / ');
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

    return GestureDetector(
      onTap: isLast ? null : onTap,
      child: Text(
        segment,
        style: TextStyle(
          color: isLast ? null : colorScheme.primary,
          decoration: isLast ? null : TextDecoration.underline,
        ),
      ),
    );
  }
}
