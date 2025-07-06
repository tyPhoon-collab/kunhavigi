import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

abstract interface class Saver {
  Future<void> save(
    ByteData bytes, {
    required String name,
    required String mimeType,
  });
}

class FileSaverDirectlySaver implements Saver {
  const FileSaverDirectlySaver();
  @override
  Future<void> save(
    ByteData bytes, {
    required String name,
    required String mimeType,
  }) async {
    await FileSaver.instance.saveFile(
      name: name,
      bytes: bytes.buffer.asUint8List(),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
    );
  }
}

class FileSaverSelectPlaceSaver implements Saver {
  const FileSaverSelectPlaceSaver();
  @override
  Future<void> save(
    ByteData bytes, {
    required String name,
    required String mimeType,
  }) async {
    if (kIsWeb) {
      // For web, we cannot select a place to save, so we use the default saveAs method
      await FileSaver.instance.saveFile(
        name: name,
        bytes: bytes.buffer.asUint8List(),
        mimeType: MimeType.custom,
        customMimeType: mimeType,
      );
      return;
    }

    // 一貫したシグネチャでないため、微調整
    await FileSaver.instance.saveAs(
      name: p.basenameWithoutExtension(name),
      bytes: bytes.buffer.asUint8List(),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
      ext: p.extension(name),
    );
  }
}
