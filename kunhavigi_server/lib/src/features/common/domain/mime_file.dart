import 'dart:io';

sealed class MimeFile {
  MimeFile(this.file, this.mimeType);

  factory MimeFile.fromMimeType(File file, String? mimeType) {
    if (mimeType == null) {
      return UnknownMimeFile(file, null);
    }

    return switch (mimeType) {
      _ when mimeType.startsWith('text/') => TextMimeFile(file, mimeType),
      'application/json' ||
      'application/javascript' ||
      'application/xml' ||
      'application/x-yaml' ||
      'application/yaml' =>
        TextMimeFile(file, mimeType),
      _ when mimeType.startsWith('image/') => ImageMimeFile(file, mimeType),
      _ when mimeType.startsWith('video/') => VideoMimeFile(file, mimeType),
      _ when mimeType.startsWith('audio/') => AudioMimeFile(file, mimeType),
      'application/pdf' ||
      'application/msword' ||
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ||
      'application/vnd.ms-excel' ||
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' =>
        DocumentMimeFile(file, mimeType),
      'application/zip' ||
      'application/x-tar' ||
      'application/gzip' ||
      'application/x-rar-compressed' ||
      'application/x-7z-compressed' =>
        ArchiveMimeFile(file, mimeType),
      _ => UnknownMimeFile(file, mimeType),
    };
  }
  final File file;
  final String? mimeType;
}

final class TextMimeFile extends MimeFile {
  TextMimeFile(super.file, super.mimeType);
}

final class ImageMimeFile extends MimeFile {
  ImageMimeFile(super.file, super.mimeType);
}

final class VideoMimeFile extends MimeFile {
  VideoMimeFile(super.file, super.mimeType);
}

final class AudioMimeFile extends MimeFile {
  AudioMimeFile(super.file, super.mimeType);
}

final class DocumentMimeFile extends MimeFile {
  DocumentMimeFile(super.file, super.mimeType);
}

final class ArchiveMimeFile extends MimeFile {
  ArchiveMimeFile(super.file, super.mimeType);
}

final class UnknownMimeFile extends MimeFile {
  UnknownMimeFile(super.file, super.mimeType);
}
