import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:kunhavigi_flutter/main.dart';

class UploadButton extends ConsumerWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton(
      onPressed: () => _pickFiles(context, ref),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      child: const Icon(Icons.upload_file),
    );
  }

  Future<void> _pickFiles(BuildContext context, WidgetRef ref) async {
    final files = await ref.read(pickerProvider).pickFiles();

    if (files.isEmpty) {
      logger.w('No files selected');
      return;
    }
    try {
      await ref
          .read(pickAndUploadUseCaseProvider)
          .upload(ref.read(currentPathProvider), files);

      teller?.success('Files uploaded successfully');
    } on Exception catch (e) {
      teller?.error(e);
    }
  }
}
