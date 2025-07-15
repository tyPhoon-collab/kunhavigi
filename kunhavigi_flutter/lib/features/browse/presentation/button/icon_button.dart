import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/domain/sort_settings.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse_settings/presentation/browse_settings_modal.dart';
import 'package:kunhavigi_flutter/theme.dart';

class SortIconButton extends ConsumerWidget {
  const SortIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortSettings = ref.watch(currentSortSettingsProvider);

    return MenuAnchor(
      menuChildren: [
        for (final type in SortType.values)
          _SortMenuItemButton(type: type, sortSettings: sortSettings),
      ],
      builder: (context, controller, child) {
        return _IconButton(
          icon: Icons.sort,
          onPressed: controller.isOpen ? controller.close : controller.open,
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
        color: isSelected ? colorScheme.primary : null,
      ),
      trailingIcon: isSelected
          ? Icon(
              isAscending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 18,
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            )
          : null,
      closeOnActivate: false,
      onPressed: () =>
          ref.read(currentSortSettingsProvider.notifier).setSortType(type),
      child: Text(
        type.label,
        style: TextStyle(
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

class SortOrderIconButton extends ConsumerWidget {
  const SortOrderIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortSettings = ref.watch(currentSortSettingsProvider);
    final isAscending = sortSettings.order == SortOrder.ascending;

    return _IconButton(
      icon: Icons.swap_vert,
      onPressed: ref.read(currentSortSettingsProvider.notifier).toggleOrder,
      tooltip: isAscending ? 'Sort Ascending' : 'Sort Descending',
    );
  }
}

class ReloadIconButton extends ConsumerWidget {
  const ReloadIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.watch(currentPathProvider);

    return _IconButton(
      icon: Icons.refresh,
      onPressed: () => ref.invalidate(entriesProvider(currentPath)),
      tooltip: 'Reload',
    );
  }
}

class SettingsIconButton extends ConsumerWidget {
  const SettingsIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _IconButton(
      icon: Icons.settings,
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const BrowseSettingsModal(),
      ),
      tooltip: 'Settings',
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      style: IconButton.styleFrom(
        shape: shape,
        foregroundColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      icon: Icon(icon),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}
