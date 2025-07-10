// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrowseSettings _$BrowseSettingsFromJson(Map<String, dynamic> json) =>
    _BrowseSettings(
      serverUrl: json['serverUrl'] as String?,
      token: json['token'] as String?,
      hiddenPatterns: (json['hiddenPatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      showHidden: json['showHidden'] as bool?,
      ignoreUploadPatterns: (json['ignoreUploadPatterns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BrowseSettingsToJson(_BrowseSettings instance) =>
    <String, dynamic>{
      'serverUrl': instance.serverUrl,
      'token': instance.token,
      'hiddenPatterns': instance.hiddenPatterns,
      'showHidden': instance.showHidden,
      'ignoreUploadPatterns': instance.ignoreUploadPatterns,
    };
