// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;

part 'entry.freezed.dart';
part 'entry.g.dart';

extension type const RelativePath(String value) {
  const RelativePath.root() : this('.');

  bool get isRoot => value == '.';

  RelativePath get parent => RelativePath(p.dirname(value));

  List<String> segments() => value.split('/');
}

@freezed
sealed class Entry with _$Entry {
  @JsonSerializable(explicitToJson: true)
  const factory Entry.file({
    @_RelativePathConverter() required RelativePath path,
    required int size,
    required DateTime lastModifiedAt,
    required String mimeType,
  }) = FileEntry;
  @JsonSerializable(explicitToJson: true)
  const factory Entry.directory({
    @_RelativePathConverter() required RelativePath path,
  }) = DirectoryEntry;
  @JsonSerializable(explicitToJson: true)
  const factory Entry.unknown({
    @_RelativePathConverter() required RelativePath path,
  }) = UnknownEntry;

  factory Entry.fromJson(Map<String, Object?> json) => _$EntryFromJson(json);

  const Entry._();

  String get name => p.basename(path.value);
  RelativePath get parent => RelativePath(p.dirname(path.value));
}

class _RelativePathConverter implements JsonConverter<RelativePath, String> {
  const _RelativePathConverter();

  @override
  RelativePath fromJson(String json) => RelativePath(json);

  @override
  String toJson(RelativePath object) => object.value;
}
