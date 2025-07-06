import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

@freezed
sealed class Entry with _$Entry {
  const factory Entry.file({
    required String absolutePath,
    required String relativePath,
    required int size,
    required DateTime lastModifiedAt,
  }) = FileEntry;

  const factory Entry.directory({
    required String absolutePath,
    required String relativePath,
  }) = DirectoryEntry;

  const factory Entry.unknown({
    required String absolutePath,
    required String relativePath,
  }) = UnknownEntry;

  factory Entry.fromJson(Map<String, Object?> json) => _$EntryFromJson(json);

  const Entry._();

  String get name => absolutePath.split('/').last;
}
