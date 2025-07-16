import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/features/browse_settings/provider/settings_provider.dart';
import 'package:kunhavigi_flutter/features/core/presentation/teller.dart';
import 'package:kunhavigi_flutter/features/core/provider/client_provider.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';
import 'package:kunhavigi_flutter/main.dart';

sealed class ClientUseCase {
  const ClientUseCase(this.ref);

  final Ref ref;

  Client get _client => ref.read(clientProvider);
}

final class RenameUseCase extends ClientUseCase {
  const RenameUseCase(super.ref);

  Future<void> rename(RelativePath path, String newName) async {
    final _ = await _client.browse.rename(
      path: path,
      newName: newName,
    );

    ref.invalidate(entriesProvider(path.parent));
  }
}

final class DeleteUseCase extends ClientUseCase {
  const DeleteUseCase(super.ref);

  Future<void> delete(RelativePath path) async {
    await _client.browse.delete(path);
    ref.invalidate(entriesProvider(path.parent));
  }
}

final class DownloadUseCase extends ClientUseCase {
  const DownloadUseCase(super.ref);

  Future<void> download(Entry entry) async {
    final progressStream =
        _client.transfer.getDownloadUrl(entry.path).asBroadcastStream();
    String? id;

    try {
      await for (final progress in progressStream) {
        switch (progress) {
          case CopingDownloadProgress():
            id = teller?.info(
              'Preparing to download ${entry.name}',
            );
          case ZippingDownloadProgress():
            id = teller?.info('Zipping ${entry.name} for download');
          case CompletedDownloadProgress(:final downloadUrl):
            await ref.read(saverProvider).saveFromUrl(
                  downloadUrl,
                  name: entry.name,
                  mimeType: switch (entry) {
                    final FileEntry file => file.mimeType,
                    final DirectoryEntry _ => 'application/zip',
                    final UnknownEntry _ => 'application/octet-stream',
                  },
                );
            if (id != null) teller?.dismiss(id);
            teller?.success('Download completed for ${entry.name}');
        }
      }
    } on Exception catch (e) {
      if (id != null) teller?.dismiss(id);
      teller?.errorOf(e);
    }
  }
}

final class UploadUseCase extends ClientUseCase {
  const UploadUseCase(super.ref);

  Future<void> upload(
    RelativePath path,
    Stream<ByteData> data,
    int size,
  ) async {
    final progressStream =
        _client.transfer.uploadFile(path: path, data: data).asBroadcastStream();

    teller?.progress(
      'Uploading ${path.name}',
      progressStream.map((progress) {
        return Progress(
          total: size,
          current: progress.current,
          isComplete: progress.isComplete,
        );
      }),
      onError: (error) => switch (error) {
        final FileAlreadyExistsException _ => teller?.error(
            'Some files already exist in the current directory. Please rename them before uploading.'),
        final genericError => teller?.errorOf(genericError),
      },
      onSuccess: () {
        teller?.success('File uploaded successfully');
        ref
          ..invalidate(entriesProvider(path.parent))
          ..invalidate(searchedEntriesProvider);
      },
    );
  }
}

final class DropAndUploadUseCase {
  const DropAndUploadUseCase(this.ref);

  final Ref ref;

  Future<void> upload(RelativePath dir, List<FileWithSource> items) async {
    final settings = await ref.read(currentBrowseSettingsProvider.future);
    final uploader = ref.read(uploadUseCaseProvider);

    final uploadTasks = <Future<void>>[];

    for (final item in items) {
      final path = dir.joined(item.name);
      if (!settings.shouldUpload(path)) continue;

      uploadTasks.add(
        uploader.upload(
          path,
          item.file.openRead().map(ByteData.sublistView),
          await item.file.length(),
        ),
      );
    }

    await Future.wait(uploadTasks);
  }
}

final class PickAndUploadUseCase {
  const PickAndUploadUseCase(this.ref);

  final Ref ref;

  Future<void> upload(RelativePath dir, List<PlatformFile> files) async {
    final settings = await ref.read(currentBrowseSettingsProvider.future);
    final uploader = ref.read(uploadUseCaseProvider);

    final uploadTasks = <Future<void>>[];

    for (final file in files) {
      final path = dir.joined(file.name);
      if (!settings.shouldUpload(path)) continue;

      uploadTasks.add(
        uploader.upload(
          path,
          file.readStream!
              .map((bytes) => ByteData.sublistView(Uint8List.fromList(bytes))),
          file.size,
        ),
      );
    }

    await Future.wait(uploadTasks);
  }
}
