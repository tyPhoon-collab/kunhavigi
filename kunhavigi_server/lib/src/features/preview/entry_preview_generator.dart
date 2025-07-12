import 'package:kunhavigi_server/src/features/common/domain/mime_file.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';

abstract interface class EntryPreviewGenerator {
  Future<EntryPreview> generate(covariant MimeFile mimeFile);
}

class TextPreviewGenerator implements EntryPreviewGenerator {
  TextPreviewGenerator({this.maxLength = 3000});
  final int maxLength;

  @override
  Future<EntryPreview> generate(TextMimeFile mimeFile) async {
    final stream = mimeFile.file.openRead();
    final buffer = StringBuffer();
    var isComplete = true;

    await for (final chunk in stream) {
      final chunkString = String.fromCharCodes(chunk);

      if (buffer.length + chunkString.length <= maxLength) {
        buffer.write(chunkString);
      } else {
        final remainingSpace = maxLength - buffer.length;
        if (remainingSpace > 0) {
          buffer.write(chunkString.substring(0, remainingSpace));
        }
        isComplete = false;
        break;
      }
    }

    final text = isComplete
        ? buffer.toString()
        : '$buffer\n\n... (truncated, file is larger than $maxLength characters)';

    return EntryPreview.text(text: text);
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
