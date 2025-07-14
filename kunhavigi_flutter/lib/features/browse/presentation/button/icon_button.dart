import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/domain/sort_settings.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse_settings/presentation/browse_settings_modal.dart';

class SortIconButton extends ConsumerWidget {
  const SortIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortSettings = ref.watch(currentSortSettingsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return MenuAnchor(
      menuChildren: [
        for (final type in SortType.values)
          _SortMenuItemButton(
            type: type,
            sortSettings: sortSettings,
          ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          icon: Icon(
            Icons.sort,
            color: colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          tooltip: 'Sort',
        );
      },
    );
  }
}

class _SortMenuItemButton extends ConsumerWidget {
  const _SortMenuItemButton({
    required this.type,
    required this.sortSettings,
  });

  final SortType type;
  final SortSettings sortSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = sortSettings.type == type;
    final isAscending = sortSettings.order == SortOrder.ascending;

    return MenuItemButton(
      leadingIcon: Icon(
        type.icon,
        size: 20,
        color: isSelected
            ? colorScheme.primary
            : colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      trailingIcon: isSelected
          ? Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 18,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            )
          : null,
      closeOnActivate: false,
      onPressed: () {
        ref.read(currentSortSettingsProvider.notifier).setSortType(type);
      },
      child: Text(
        type.label,
        style: TextStyle(
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class SortOrderIconButton extends ConsumerWidget {
  const SortOrderIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final sortSettings = ref.watch(currentSortSettingsProvider);
    final isAscending = sortSettings.order == SortOrder.ascending;

    return IconButton(
      icon: Icon(
        Icons.swap_vert,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      onPressed: () {
        ref.read(currentSortSettingsProvider.notifier).toggleOrder();
      },
      tooltip: isAscending ? 'Sort Ascending' : 'Sort Descending',
    );
  }
}

class ReloadIconButton extends ConsumerWidget {
  const ReloadIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final currentPath = ref.watch(currentPathProvider);

    return IconButton(
      icon: Icon(
        Icons.refresh,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      onPressed: () => ref.invalidate(entriesProvider(currentPath)),
      tooltip: 'Reload',
    );
  }
}

class SettingsIconButton extends ConsumerWidget {
  const SettingsIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        Icons.settings,
        color: colorScheme.onSurface.withValues(alpha: 0.8),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const BrowseSettingsModal(),
        );
      },
      tooltip: 'Settings',
    );
  }
}
