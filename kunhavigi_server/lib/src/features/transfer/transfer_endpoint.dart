import 'dart:io';
import 'dart:typed_data';

import 'package:kunhavigi_server/src/features/common/domain/entry.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  /// Download a file from the server
  Future<ByteData> downloadFile(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = exactFile(normalizedPath);

    final bytes = file.readAsBytesSync();
    return ByteData.sublistView(bytes);
  }

  /// Upload a file to the server
  Future<Entry> uploadFile(
    Session session, {
    required RelativePath path,
    required ByteData data,
  }) async {
    final normalizedPath = validateAndNormalizePath(path);
    final file = File(normalizedPath.value);
    await file.writeAsBytes(data.buffer.asUint8List());

    return createEntry(file);
  }
}
