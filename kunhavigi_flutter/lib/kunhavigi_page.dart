import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/icon_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/upload_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/entries_list_view.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/file_drop_zone.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/path_breadcrumb.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/logger.dart';

class KunhavigiPage extends ConsumerWidget {
  const KunhavigiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

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
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(child: PathBreadcrumb()),
                  SortIconButton(),
                  SortOrderIconButton(),
                  ReloadIconButton(),
                  SettingsIconButton(),
                ],
              ),
            ),
          ),
        ),
        body: const EntriesListView(padding: EdgeInsets.only(bottom: 86)),
        floatingActionButton: const UploadButton(),
      ),
    );
  }
}
