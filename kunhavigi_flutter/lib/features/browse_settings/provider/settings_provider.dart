import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse_settings/data/browse_settings_repository.dart';
import 'package:kunhavigi_flutter/features/browse_settings/domain/browse_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentBrowseSettings extends _$CurrentBrowseSettings {
  @override
  Future<BrowseSettings> build() async {
    return ref.watch(_browseSettingsRepositoryProvider).get();
  }

  Future<void> set(BrowseSettings settings) async {
    await ref.watch(_browseSettingsRepositoryProvider).set(settings);
    state = AsyncValue.data(settings);
  }

  void reset() {
    ref.watch(_browseSettingsRepositoryProvider).reset();
    state = AsyncValue.data(BrowseSettings.defaultSettings());
  }
}

@Riverpod(keepAlive: true)
SharedPreferencesBrowseSettingsRepository _browseSettingsRepository(Ref ref) {
  return SharedPreferencesBrowseSettingsRepository();
}
