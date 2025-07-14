import 'dart:io';

import 'package:kunhavigi_server/src/features/future_call/future_call_id.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod/serverpod.dart';

Directory getDownloadsDirectory() {
  final downloadsDir = Directory('web/static/downloads')
    ..createSync(recursive: true);
  return downloadsDir;
}

String getDownloadUrlFromPath(ServerConfig config, String path) {
  final scheme = config.publicScheme;
  final host = config.publicHost;
  final port = config.port;

  final baseUrl = '$scheme://$host:$port';
  return '$baseUrl/downloads/${p.basename(path)}';
}

Future<void> registerDownloadCleanup(
  Session session,
  String path, {
  Duration delay = const Duration(hours: 1),
}) async {
  await session.serverpod.futureCallWithDelay(
    FutureCallName.cleanupDownload.name,
    DownloadedFile(path: path),
    delay,
  );
}
