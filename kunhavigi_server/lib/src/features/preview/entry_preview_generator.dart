import 'dart:convert';

import 'package:kunhavigi_server/src/features/common/domain/mime_file.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';

abstract interface class EntryPreviewGenerator {
  Future<EntryPreview> generate(covariant MimeFile mimeFile);
}

class TextPreviewGenerator implements EntryPreviewGenerator {
  TextPreviewGenerator({this.maxBytes = 10 * 1024}); // 10KB limit
  final int maxBytes;

  @override
  Future<EntryPreview> generate(TextMimeFile mimeFile) async {
    final file = mimeFile.file;
    final fileSize = await file.length();

    final bytesToRead = fileSize > maxBytes ? maxBytes : fileSize;

    final bytes = await file.openRead(0, bytesToRead).toList();
    final flatBytes = bytes.expand((chunk) => chunk).toList();

    final text = const Utf8Decoder(allowMalformed: true).convert(flatBytes);

    final result = fileSize <= maxBytes
        ? text
        : '$text\n\n... (truncated, file is larger than ${_formatBytes(maxBytes)})';

    return EntryPreview.text(text: result);
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

class ImagePreviewGenerator implements EntryPreviewGenerator {
  ImagePreviewGenerator({this.maxImageSize = 5 * 1024 * 1024}); // 5MB limit

  final int maxImageSize;

  @override
  Future<EntryPreview> generate(covariant MimeFile mimeFile) async {
    final file = mimeFile.file;

    final fileSize = await file.length();
    if (fileSize > maxImageSize) {
      return const EntryPreview.unknown();
    }

    final bytes = await file.readAsBytes();

    return EntryPreview.image(base64: bytes);
  }
}
