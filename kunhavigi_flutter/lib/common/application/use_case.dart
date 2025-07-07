import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/application/picker.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/client.dart';

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

  Future<void> download(FileEntry entry) async {
    final bytes = await _client.transfer.downloadFile(entry.path);
    await ref.read(saverProvider).save(
          bytes,
          name: entry.name,
          mimeType: entry.mimeType,
        );
  }
}

final class UploadUseCase extends ClientUseCase {
  const UploadUseCase(super.ref);

  Future<void> upload(RelativePath path, Uint8List bytes) async {
    final _ = await _client.transfer.uploadFile(
      path: path,
      data: ByteData.sublistView(bytes),
    );

    ref.invalidate(entriesProvider(path.parent));
  }
}

final class DropAndUploadUseCase {
  const DropAndUploadUseCase({required this.uploader});

  final UploadUseCase uploader;

  Future<void> upload(RelativePath dir, List<DropItemFile> items) async {
    await Future.wait([
      for (final item in items)
        uploader.upload(
          dir.append(item.name),
          await item.readAsBytes(),
        ),
    ]);
  }
}

final class PickAndUploadUseCase {
  const PickAndUploadUseCase({required this.uploader, required this.picker});

  final Picker picker;
  final UploadUseCase uploader;

  Future<void> upload(RelativePath dir, List<PlatformFile> files) async {
    if (files.isEmpty) {
      return;
    }

    await Future.wait([
      for (final file in files)
        uploader.upload(
          dir.append(file.name),
          file.bytes!,
        ),
    ]);
  }
}
