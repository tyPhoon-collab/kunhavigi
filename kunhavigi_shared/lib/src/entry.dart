import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry.freezed.dart';
part 'entry.g.dart';

@freezed
abstract class Entry with _$Entry {
  const factory Entry.file({
    required String name,
    required String path,
    required int size,
    required DateTime lastModifiedAt,
  }) = FileEntry;

  const factory Entry.directory({required String name, required String path}) =
      DirectoryEntry;

  const factory Entry.unknown({required String name, required String path}) =
      UnknownEntry;

  factory Entry.fromJson(Map<String, Object?> json) => _$EntryFromJson(json);
}
