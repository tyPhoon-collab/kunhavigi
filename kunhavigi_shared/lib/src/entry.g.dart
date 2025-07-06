// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntry _$FileEntryFromJson(Map<String, dynamic> json) => FileEntry(
  absolutePath: json['absolutePath'] as String,
  relativePath: json['relativePath'] as String,
  size: (json['size'] as num).toInt(),
  lastModifiedAt: DateTime.parse(json['lastModifiedAt'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$FileEntryToJson(FileEntry instance) => <String, dynamic>{
  'absolutePath': instance.absolutePath,
  'relativePath': instance.relativePath,
  'size': instance.size,
  'lastModifiedAt': instance.lastModifiedAt.toIso8601String(),
  'runtimeType': instance.$type,
};

DirectoryEntry _$DirectoryEntryFromJson(Map<String, dynamic> json) =>
    DirectoryEntry(
      absolutePath: json['absolutePath'] as String,
      relativePath: json['relativePath'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$DirectoryEntryToJson(DirectoryEntry instance) =>
    <String, dynamic>{
      'absolutePath': instance.absolutePath,
      'relativePath': instance.relativePath,
      'runtimeType': instance.$type,
    };

UnknownEntry _$UnknownEntryFromJson(Map<String, dynamic> json) => UnknownEntry(
  absolutePath: json['absolutePath'] as String,
  relativePath: json['relativePath'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UnknownEntryToJson(UnknownEntry instance) =>
    <String, dynamic>{
      'absolutePath': instance.absolutePath,
      'relativePath': instance.relativePath,
      'runtimeType': instance.$type,
    };
