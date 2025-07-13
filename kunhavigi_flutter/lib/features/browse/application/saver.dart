import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

abstract interface class Saver {
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  });

  Future<void> saveFromUrl(
    String url, {
    required String name,
    required String mimeType,
  });
}

class CrossPlatformSaver implements Saver {
  CrossPlatformSaver({
    required this.webSaver,
    required this.nativeSaver,
  });

  final Saver webSaver;
  final Saver nativeSaver;

  @override
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  }) async {
    if (kIsWeb) {
      await webSaver.save(
        stream,
        name: name,
        mimeType: mimeType,
      );
      return;
    }

    await nativeSaver.save(
      stream,
      name: name,
      mimeType: mimeType,
    );
  }

  @override
  Future<void> saveFromUrl(
    String url, {
    required String name,
    required String mimeType,
  }) async {
    if (kIsWeb) {
      await webSaver.saveFromUrl(
        url,
        name: name,
        mimeType: mimeType,
      );
      return;
    }

    await nativeSaver.saveFromUrl(
      url,
      name: name,
      mimeType: mimeType,
    );
  }
}

class FileSaverSaveAsSaver implements Saver {
  const FileSaverSaveAsSaver();

  @override
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  }) async {
    final bytes = await _streamToBytes(stream);
    await FileSaver.instance.saveAs(
      name: p.basenameWithoutExtension(name),
      bytes: bytes,
      mimeType: MimeType.custom,
      customMimeType: mimeType,
      ext: _toExtension(name, mimeType),
    );
  }

  @override
  Future<void> saveFromUrl(
    String url, {
    required String name,
    required String mimeType,
  }) async {
    await FileSaver.instance.saveAs(
      name: p.basenameWithoutExtension(name),
      link: LinkDetails(link: url),
      ext: _toExtension(name, mimeType),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
    );
  }

  String _toExtension(String name, String mimeType) {
    final extension = p.extension(name).replaceFirst('.', '');
    if (extension.isEmpty) {
      return mimeType == 'application/zip' ? 'zip' : '';
    }
    return extension;
  }
}

class FileSaverDirectlySaver implements Saver {
  const FileSaverDirectlySaver();

  @override
  Future<void> save(
    Stream<ByteData> stream, {
    required String name,
    required String mimeType,
  }) async {
    final bytes = await _streamToBytes(stream);
    await FileSaver.instance.saveFile(
      name: name,
      bytes: bytes,
      mimeType: MimeType.custom,
      customMimeType: mimeType,
    );
  }

  @override
  Future<void> saveFromUrl(
    String url, {
    required String name,
    required String mimeType,
  }) async {
    await FileSaver.instance.saveFile(
      name: name,
      link: LinkDetails(link: url),
      mimeType: MimeType.custom,
      customMimeType: mimeType,
    );
  }
}

Future<Uint8List> _streamToBytes(Stream<ByteData> stream) async {
  final chunks = <int>[];
  await for (final chunk in stream) {
    chunks.addAll(chunk.buffer.asUint8List());
  }
  return Uint8List.fromList(chunks);
}
