import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse_settings/data/browse_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesBrowseSettingsRepository browseSettingsRepository(Ref ref) {
  return SharedPreferencesBrowseSettingsRepository();
}
