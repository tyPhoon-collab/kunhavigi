import 'dart:typed_data';

import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  /// Download a file from the server
  Future<ByteData> downloadFile(Session session, String path) async {
    final normalizedPath = validateAndNormalizePath(path);

    final file = existingFile(normalizedPath);

    final bytes = file.readAsBytesSync();
    return ByteData.sublistView(bytes);
  }
}
