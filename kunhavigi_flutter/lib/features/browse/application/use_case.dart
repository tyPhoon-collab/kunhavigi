import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/features/browse/provider/use_case_provider.dart';
import 'package:kunhavigi_flutter/features/common/presentation/teller.dart';
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
    final FileEntry entry_;
    var zipFileCreated = false;
    var name = entry.name;

    switch (entry) {
      case final FileEntry file:
        entry_ = file;
      case final DirectoryEntry dir:
        // Create a zip file for the directory
        final zipFile = await _client.transfer.createZip(dir.path);
        entry_ = zipFile;
        zipFileCreated = true;
        name = '$name.zip';
      case final UnknownEntry unknown:
        throw ArgumentError('Cannot download unknown entry: ${unknown.path}');
    }

    final stream =
        _client.transfer.downloadFile(entry_.path).asBroadcastStream();

    var current = 0;

    final id = teller?.progress('Downloading $name', stream.map((event) {
      return Progress(
        total: entry_.size,
        current: current += event.lengthInBytes,
      );
    }));

    try {
      await ref.read(saverProvider).save(
            stream,
            name: name,
            mimeType: entry_.mimeType,
          );

      // Cleanup zip file if it was created
      if (zipFileCreated) {
        await _client.browse.delete(entry_.path);
      }
    } on Exception catch (e) {
      logger.e('Failed to download ${entry_.name}: $e');
    } finally {
      teller?.dismiss(id!);
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
    final uploader = ref.read(uploadUseCaseProvider);

    for (final item in items) {
      await uploader.upload(
        dir.joined(item.name),
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
    final uploader = ref.read(uploadUseCaseProvider);

    for (final file in files) {
      await uploader.upload(
        dir.joined(file.name),
        file.readStream!
            .map((bytes) => ByteData.sublistView(Uint8List.fromList(bytes))),
        file.size,
      );
    }

    ref.invalidate(entriesProvider);
  }
}
