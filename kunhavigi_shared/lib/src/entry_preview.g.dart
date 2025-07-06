// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextEntryPreview _$TextEntryPreviewFromJson(Map<String, dynamic> json) =>
    TextEntryPreview(
      text: json['text'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TextEntryPreviewToJson(TextEntryPreview instance) =>
    <String, dynamic>{'text': instance.text, 'runtimeType': instance.$type};

ImageEntryPreview _$ImageEntryPreviewFromJson(Map<String, dynamic> json) =>
    ImageEntryPreview(
      base64: const BytesToBase64Converter().fromJson(json['base64'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ImageEntryPreviewToJson(ImageEntryPreview instance) =>
    <String, dynamic>{
      'base64': const BytesToBase64Converter().toJson(instance.base64),
      'runtimeType': instance.$type,
    };

UnknownEntryPreview _$UnknownEntryPreviewFromJson(Map<String, dynamic> json) =>
    UnknownEntryPreview($type: json['runtimeType'] as String?);

Map<String, dynamic> _$UnknownEntryPreviewToJson(
  UnknownEntryPreview instance,
) => <String, dynamic>{'runtimeType': instance.$type};
