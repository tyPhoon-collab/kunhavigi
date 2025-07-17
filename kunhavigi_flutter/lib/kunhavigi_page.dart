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
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: _AppBarBottom(),
          ),
          actions: const [
            ThemeToggleIconButton(),
          ],
          actionsPadding: const EdgeInsets.only(right: 8),
        ),
        body: const EntriesListView(padding: EdgeInsets.only(bottom: 86)),
        floatingActionButton: const UploadButton(),
      ),
    );
  }
}

class _AppBarBottom extends StatelessWidget {
  const _AppBarBottom();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final foregroundColor = colorScheme.onSurface.withValues(alpha: 0.8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: foregroundColor),
          child: const Row(
            spacing: 4,
            children: [
              Expanded(child: PathBreadcrumb()),
              SearchIconButton(),
              SortIconButton(),
              SortOrderIconButton(),
              ReloadIconButton(),
              SettingsIconButton(),
            ],
          ),
        ),
      ),
    );
  }
}
