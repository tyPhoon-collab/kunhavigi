import 'dart:io';
import 'dart:typed_data';

import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  /// Download a file from the server
  Stream<ByteData> downloadFile(Session session, RelativePath path) async* {
    final normalizedPath = validateAndNormalizePath(path);

    final file = exactFile(normalizedPath);

    // Using default chunk size from openRead() (typically 64KB)
    final fileStream = file.openRead();

    await for (final chunk in fileStream) {
      yield ByteData.sublistView(Uint8List.fromList(chunk));
    }
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
      await randomAccessFile.flush();
    } catch (e) {
      throw Exception('Failed to upload file: $e');
    } finally {
      await randomAccessFile.close();
    }

    return buildEntry(file);
  }
}
