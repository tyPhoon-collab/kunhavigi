import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

abstract interface class Saver {
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  });
}

class FileSaverDirectlySaver implements Saver {
  const FileSaverDirectlySaver();

  @override
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  }) async {
    final chunks = <int>[];
    await for (final chunk in stream) {
      chunks.addAll(chunk.buffer.asUint8List());
    }

    await FileSaver.instance.saveFile(
      name: name,
      bytes: Uint8List.fromList(chunks),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
    );
  }
}

class FileSaverSelectPlaceSaver implements Saver {
  const FileSaverSelectPlaceSaver();

  @override
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  }) async {
    final chunks = <int>[];
    await for (final chunk in stream) {
      chunks.addAll(chunk.buffer.asUint8List());
    }

    final bytes = Uint8List.fromList(chunks);

    if (kIsWeb) {
      await FileSaver.instance.saveFile(
        name: name,
        bytes: bytes,
        mimeType: MimeType.custom,
        customMimeType: mimeType,
      );
      return;
    }

    await FileSaver.instance.saveAs(
      name: p.basenameWithoutExtension(name),
      bytes: bytes,
      mimeType: MimeType.custom,
      customMimeType: mimeType,
      ext: p.extension(name).replaceFirst('.', ''),
    );
  }
}
