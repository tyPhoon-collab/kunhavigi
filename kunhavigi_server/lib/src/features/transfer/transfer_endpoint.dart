import 'dart:io';
import 'dart:typed_data';

import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/features/transfer/archive.dart';
import 'package:kunhavigi_server/src/features/transfer/download.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  /// Download a file or folder from the server
  Stream<ByteData> downloadFile(Session session, RelativePath path) async* {
    final normalizedPath = validateAndNormalizePath(path);
    final file = exactFile(normalizedPath);
    final fileStream = file.openRead();

    await for (final chunk in fileStream) {
      yield ByteData.sublistView(Uint8List.fromList(chunk));
    }
  }

  /// Get a download URL for a file or folder
  /// Folders are zipped before download
  Future<String> getDownloadUrl(
    Session session,
    RelativePath path,
  ) async {
    final normalizedPath = validateAndNormalizePath(path);
    final entity = exactEntity(normalizedPath);

    final downloadsDir = getDownloadsDirectory();
    final outPath = '${downloadsDir.path}/${const Uuid().v4()}';

    switch (entity) {
      case final File file:
        await file.copy(outPath);
      case final Directory dir:
        final zipFile = File(outPath);
        await writeZip(dir, zipFile);
      default:
        throw UnsupportedError('Unsupported entity type for download');
    }

    // Schedule cleanup of the downloaded file after 1 hour
    await registerDownloadCleanup(session, outPath);

    return getDownloadUrlFromPath(session as MethodCallSession, outPath);
  }

  /// Upload a file to the server
  Future<Entry> uploadFile(
    Session session, {
    required RelativePath path,
    required Stream<ByteData> data,
  }) async {
    final normalizedPath = validateAndNormalizePath(path);
    final file = File(normalizedPath.value);

    // Ensure the directory exists
    await file.parent.create(recursive: true);

    final randomAccessFile = await file.open(mode: FileMode.write);

    try {
      await for (final byteData in data) {
        await randomAccessFile.writeFrom(byteData.buffer.asUint8List());
      }
      await randomAccessFile.close();
    } catch (e) {
      await randomAccessFile.close();
      if (file.existsSync()) {
        await file.delete();
      }
      rethrow;
    }

    return buildEntry(file);
  }
}
