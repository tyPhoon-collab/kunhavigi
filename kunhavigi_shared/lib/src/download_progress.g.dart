// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CopingDownloadProgress _$CopingDownloadProgressFromJson(
  Map<String, dynamic> json,
) => CopingDownloadProgress($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CopingDownloadProgressToJson(
  CopingDownloadProgress instance,
) => <String, dynamic>{'runtimeType': instance.$type};

ZippingDownloadProgress _$ZippingDownloadProgressFromJson(
  Map<String, dynamic> json,
) => ZippingDownloadProgress($type: json['runtimeType'] as String?);

Map<String, dynamic> _$ZippingDownloadProgressToJson(
  ZippingDownloadProgress instance,
) => <String, dynamic>{'runtimeType': instance.$type};

CompletedDownloadProgress _$CompletedDownloadProgressFromJson(
  Map<String, dynamic> json,
) => CompletedDownloadProgress(
  downloadUrl: json['downloadUrl'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CompletedDownloadProgressToJson(
  CompletedDownloadProgress instance,
) => <String, dynamic>{
  'downloadUrl': instance.downloadUrl,
  'runtimeType': instance.$type,
};
