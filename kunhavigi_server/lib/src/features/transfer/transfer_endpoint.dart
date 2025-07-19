import 'dart:io';
import 'dart:typed_data';

import 'package:kunhavigi_server/src/features/common/domain/mime_file.dart';
import 'package:kunhavigi_server/src/features/common/domain/path.dart';
import 'package:kunhavigi_server/src/features/preview/entry_preview_generator.dart';
import 'package:kunhavigi_server/src/features/transfer/archive.dart';
import 'package:kunhavigi_server/src/features/transfer/download.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:serverpod/serverpod.dart';

class TransferEndpoint extends Endpoint {
  final _textPreviewGenerator = TextPreviewGenerator();
  final _imagePreviewGenerator = ImagePreviewGenerator();
  final _videoPreviewGenerator = VideoPreviewGenerator();

  /// Peek at the content of a file to generate a preview.
  Future<EntryPreview> peekEntry(Session session, RelativePath path) async {
    final normalizedPath = validateAndNormalizePath(path);
    final mimeFile = exactMimeFile(normalizedPath);

    final preview = switch (mimeFile) {
      final TextMimeFile file => await _textPreviewGenerator.generate(file),
      final ImageMimeFile file => await _imagePreviewGenerator.generate(file),
      final VideoMimeFile file => await _videoPreviewGenerator.generate(file),
      _ => const EntryPreview.unknown(),
    };

    final title = '${preview.runtimeType}(${mimeFile.mimeType})';
    session.log('Generated $title preview for ${path.value}');

    return preview;
  }

  /// Download a file or folder from the server
  Stream<ByteData> downloadFile(Session session, RelativePath path) async* {
    final normalizedPath = validateAndNormalizePath(path);
    final file = exactFile(normalizedPath);
    final fileStream = file.openRead();

    await for (final chunk in fileStream) {
      yield ByteData.sublistView(Uint8List.fromList(chunk));
    }

    session.log('Downloaded ${path.value} (${file.lengthSync()} bytes)');
  }

  /// Get a download URL for a file or folder with progress updates
  /// Folders are zipped before download
  Stream<DownloadProgress> getDownloadUrl(
    Session session,
    RelativePath path,
  ) async* {
    final normalizedPath = validateAndNormalizePath(path);
    final entity = exactEntity(normalizedPath);

    final downloadsDir = getDownloadsDirectory();
    final outPath = '${downloadsDir.path}/${const Uuid().v4()}';

    switch (entity) {
      case final File file:
        yield const DownloadProgress.copying();
        await file.copy(outPath);
        session.log('Generated download URL for file: ${path.value}');

      case final Directory dir:
        yield const DownloadProgress.zipping();
        final zipFile = File(outPath);
        await writeZip(dir, zipFile);
        session.log(
            'Generated download URL for directory (zipped): ${path.value}');

      default:
        session.log(
            'Unsupported entity type for download: ${entity.runtimeType}',
            level: LogLevel.warning);
        throw UnsupportedError('Unsupported entity type for download');
    }

    // Schedule cleanup of the downloaded file after 1 hour
    await registerDownloadCleanup(session, outPath);

    final downloadUrl =
        getDownloadUrlFromPath(session.serverpod.config.webServer!, outPath);

    yield DownloadProgress.completed(downloadUrl: downloadUrl);
  }

  /// Upload a file to the server with progress updates
  Stream<UploadProgress> uploadFile(
    Session session, {
    required RelativePath path,
    required Stream<ByteData> data,
  }) async* {
    final normalizedPath = validateAndNormalizePath(path);
    final file = File(normalizedPath.value);

    // Check if file already exists and handle appropriately
    if (file.existsSync()) {
      session.log(
        'File already exists: ${path.value}',
        level: LogLevel.warning,
      );
      throw FileAlreadyExistsException(path: normalizedPath.value);
    }

    // Ensure the directory exists
    await file.parent.create(recursive: true);

    RandomAccessFile? randomAccessFile;
    var totalBytes = 0;

    try {
      randomAccessFile = await file.open(mode: FileMode.write);

      await for (final byteData in data) {
        final bytes = byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        );

        await randomAccessFile.writeFrom(bytes);
        totalBytes += bytes.length;

        // Emit progress update
        yield UploadProgress(
          current: totalBytes,
          isComplete: false,
        );
      }
      await randomAccessFile.close();

      session.log('Uploaded ${path.value} ($totalBytes bytes)');

      // Emit final result
      yield UploadProgress(
        current: totalBytes,
        isComplete: true,
      );
    } on Exception catch (e) {
      session.log(
        'Upload failed for ${path.value}: $e',
        level: LogLevel.error,
        exception: e,
      );
      await randomAccessFile?.close();
      // Clean up file on any error
      if (file.existsSync()) {
        await file.delete();
      }
      rethrow;
    }
  }
}
