import 'package:freezed_annotation/freezed_annotation.dart';

part 'browse_settings.freezed.dart';
part 'browse_settings.g.dart';

@freezed
sealed class BrowseSettings with _$BrowseSettings {
  const factory BrowseSettings({
    String? serverUrl,
    String? token,
    List<String>? hiddenPatterns,
    bool? showHidden,
    List<String>? ignoreUploadPatterns,
  }) = _BrowseSettings;

  factory BrowseSettings.fromJson(Map<String, Object?> json) =>
      _$BrowseSettingsFromJson(json);

  const BrowseSettings._();

  factory BrowseSettings.defaultSettings() {
    return const BrowseSettings(
      hiddenPatterns: ['.*'],
      showHidden: false,
      ignoreUploadPatterns: ['.DS_Store'],
    );
  }

  factory BrowseSettings.fromFormValues(Map<String, dynamic> values) {
    return BrowseSettings(
      serverUrl: values['serverUrl'] as String?,
      token: values['token'] as String?,
      hiddenPatterns: (values['hiddenPatterns'] as String?)
          ?.split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      showHidden: values['showHidden'] as bool? ?? false,
      ignoreUploadPatterns: (values['ignoreUploadPatterns'] as String?)
          ?.split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }

  Map<String, dynamic> toFormValues() {
    return {
      'serverUrl': serverUrl ?? '',
      'token': token ?? '',
      'hiddenPatterns': hiddenPatterns?.join(', ') ?? '',
      'showHidden': showHidden ?? false,
      'ignoreUploadPatterns': ignoreUploadPatterns?.join(', ') ?? '',
    };
  }
}
