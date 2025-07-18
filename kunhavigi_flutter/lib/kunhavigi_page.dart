import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/icon_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/upload_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/entries_list_view.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/file_drop_zone.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/path_breadcrumb.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/features/theme/presentation/theme_toggle_icon_button.dart';
import 'package:kunhavigi_flutter/logger.dart';

const _mobileWidthThreshold = 600;

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FileDropZone(
      onFilesDropped: (files) async {
        if (files.isEmpty) {
          logger.w('No files dropped');
          return;
        }
        final currentPath = ref.read(currentPathProvider);
        await ref.read(dropAndUploadUseCaseProvider).upload(currentPath, files);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kunhavigi'),
          actions: const [ThemeToggleIconButton()],
          actionsPadding: const EdgeInsets.only(right: 8),
        ),
        body: const Column(
          children: [
            _Header(),
            Expanded(
                child: EntriesListView(padding: EdgeInsets.only(bottom: 86))),
          ],
        ),
        floatingActionButton: const UploadButton(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = colorScheme.onSurface.withValues(alpha: 0.8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: foregroundColor),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < _mobileWidthThreshold;

              if (isMobile) {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4,
                  children: [PathBreadcrumb(), _Tools(isExpanded: true)],
                );
              }
              // 通常はRow
              return const Row(
                spacing: 4,
                children: [
                  Expanded(child: PathBreadcrumb()),
                  _Tools(isExpanded: false)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Tools extends StatelessWidget {
  const _Tools({required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    const children = [
      SearchIconButton(),
      SortIconButton(),
      SortOrderIconButton(),
      ReloadIconButton(),
      SettingsIconButton(),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: isExpanded
          ? children.map((e) => Expanded(child: e)).toList()
          : children,
    );
  }
}
