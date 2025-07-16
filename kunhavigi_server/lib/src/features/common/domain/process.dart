import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<int> countEntries({
  required String path,
  required String query,
  Duration timeout = const Duration(seconds: 5),
}) async {
  const script = r'set -o pipefail; find "$1" -mindepth 1 -name "*$2*" | wc -l';
  final process = await Process.start(
    'sh',
    ['-c', script, '_', path, query],
  );

  final exitCode = await process.exitCode.timeout(timeout);

  if (exitCode == 0) {
    final output = await process.stdout.transform(utf8.decoder).join();
    return int.parse(output.trim());
  } else {
    final error = await process.stderr.transform(utf8.decoder).join();
    throw Exception('Failed to count entries: $error');
  }
}
