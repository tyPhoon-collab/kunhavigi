import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/features/browse_settings/provider/settings_provider.dart';
import 'package:kunhavigi_flutter/features/common/presentation/teller.dart';
import 'package:kunhavigi_flutter/features/common/provider/client_provider.dart';
import 'package:kunhavigi_flutter/features/platform/types.dart';
import 'package:kunhavigi_flutter/logger.dart';
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
    final url = await _client.transfer.getDownloadUrl(entry.path);

    try {
      await ref.read(saverProvider).saveFromUrl(
            url,
            name: entry.name,
            mimeType: switch (entry) {
              final FileEntry file => file.mimeType,
              final DirectoryEntry _ => 'application/zip',
              final UnknownEntry _ => 'application/octet-stream',
            },
          );
    } on Exception catch (e) {
      logger.e('Failed to download ${entry.name}: $e');
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
    final stream = data.asBroadcastStream();
    var current = 0;

    final id = teller?.progress('Uploading ${path.name}', stream.map((event) {
      return Progress(
        total: size,
        current: current += event.lengthInBytes,
      );
    }));
    try {
      final _ = await _client.transfer.uploadFile(path: path, data: stream);
    } finally {
      teller?.dismiss(id!);
    }
  }
}

final class DropAndUploadUseCase {
  const DropAndUploadUseCase(this.ref);

  final Ref ref;

  Future<void> upload(RelativePath dir, List<FileWithSource> items) async {
    final settings = await ref.read(currentBrowseSettingsProvider.future);
    final uploader = ref.read(uploadUseCaseProvider);

    for (final item in items) {
      final path = dir.joined(item.name);
      if (!settings.shouldUpload(path)) continue;
      await uploader.upload(
        path,
        item.file.openRead().map(ByteData.sublistView),
        await item.file.length(),
      );
    }

    ref.invalidate(entriesProvider);
  }
}

final class PickAndUploadUseCase {
  const PickAndUploadUseCase(this.ref);

  final Ref ref;

  Future<void> upload(RelativePath dir, List<PlatformFile> files) async {
    final settings = await ref.read(currentBrowseSettingsProvider.future);
    final uploader = ref.read(uploadUseCaseProvider);

    for (final file in files) {
      final path = dir.joined(file.name);
      if (!settings.shouldUpload(path)) continue;
      await uploader.upload(
        path,
        file.readStream!
            .map((bytes) => ByteData.sublistView(Uint8List.fromList(bytes))),
        file.size,
      );
    }

    ref.invalidate(entriesProvider);
  }
}
