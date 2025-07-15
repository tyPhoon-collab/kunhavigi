import 'package:flutter/material.dart';
import 'package:kunhavigi_flutter/theme.dart';

class BottomSheetBase extends StatelessWidget {
  const BottomSheetBase({
    required this.header,
    required this.child,
    this.initialChildSize = 0.8,
    this.maxChildSize = 0.9,
    this.minChildSize = 0.3,
    super.key,
  });

  final Widget header;
  final Widget child;
  final double initialChildSize;
  final double maxChildSize;
  final double minChildSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      minChildSize: minChildSize,
      builder: (context, scrollController) {
        return Container(
          decoration: ShapeDecoration(
            shape: shape.copyWith(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            color: colorScheme.surface,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onClose,
    super.key,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      color: colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose ?? () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}
