// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntry _$FileEntryFromJson(Map<String, dynamic> json) => FileEntry(
  path: const _RelativePathConverter().fromJson(json['path'] as String),
  size: (json['size'] as num).toInt(),
  lastModifiedAt: DateTime.parse(json['lastModifiedAt'] as String),
  mimeType: json['mimeType'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$FileEntryToJson(FileEntry instance) => <String, dynamic>{
  'path': const _RelativePathConverter().toJson(instance.path),
  'size': instance.size,
  'lastModifiedAt': instance.lastModifiedAt.toIso8601String(),
  'mimeType': instance.mimeType,
  'runtimeType': instance.$type,
};

DirectoryEntry _$DirectoryEntryFromJson(Map<String, dynamic> json) =>
    DirectoryEntry(
      path: const _RelativePathConverter().fromJson(json['path'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DirectoryEntryToJson(DirectoryEntry instance) =>
    <String, dynamic>{
      'path': const _RelativePathConverter().toJson(instance.path),
      'runtimeType': instance.$type,
    };

UnknownEntry _$UnknownEntryFromJson(Map<String, dynamic> json) => UnknownEntry(
  path: const _RelativePathConverter().fromJson(json['path'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UnknownEntryToJson(UnknownEntry instance) =>
    <String, dynamic>{
      'path': const _RelativePathConverter().toJson(instance.path),
      'runtimeType': instance.$type,
    };
