import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

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

    await FileSaver.instance.saveAs(
      name: name,
      bytes: bytes.buffer.asUint8List(),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
      ext: '',
    );
  }
}
