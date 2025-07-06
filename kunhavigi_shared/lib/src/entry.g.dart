// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntry _$FileEntryFromJson(Map<String, dynamic> json) => FileEntry(
  name: json['name'] as String,
  path: json['path'] as String,
  size: (json['size'] as num).toInt(),
  lastModifiedAt: DateTime.parse(json['lastModifiedAt'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$FileEntryToJson(FileEntry instance) => <String, dynamic>{
  'name': instance.name,
  'path': instance.path,
  'size': instance.size,
  'lastModifiedAt': instance.lastModifiedAt.toIso8601String(),
  'runtimeType': instance.$type,
};

DirectoryEntry _$DirectoryEntryFromJson(Map<String, dynamic> json) =>
    DirectoryEntry(
      name: json['name'] as String,
      path: json['path'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DirectoryEntryToJson(DirectoryEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'runtimeType': instance.$type,
    };

UnknownEntry _$UnknownEntryFromJson(Map<String, dynamic> json) => UnknownEntry(
  name: json['name'] as String,
  path: json['path'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UnknownEntryToJson(UnknownEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'runtimeType': instance.$type,
    };
