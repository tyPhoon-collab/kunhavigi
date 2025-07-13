import 'dart:io';

import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CleanupDownload extends FutureCall<DownloadedFile> {
  @override
  Future<void> invoke(Session session, DownloadedFile? object) async {
    session.log(
      'Cleaning up downloaded file: ${object?.path}',
      level: LogLevel.info,
    );
    if (object == null) return;

    try {
      // Assuming the path is a valid file path
      final file = File(object.path);
      if (file.existsSync()) {
        await file.delete();
        session.log(
          'Deleted file: ${object.path}',
          level: LogLevel.info,
        );
      }
    } on FileSystemException catch (e, s) {
      session.log(
        'Failed to delete file: ${object.path}',
        level: LogLevel.error,
        exception: e,
        stackTrace: s,
      );
    }
  }
}
