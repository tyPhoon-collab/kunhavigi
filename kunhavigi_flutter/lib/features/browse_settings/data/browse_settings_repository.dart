import 'dart:async';
import 'dart:convert';

import 'package:kunhavigi_flutter/features/browse_settings/domain/browse_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class BrowseSettingsRepository {
  Future<BrowseSettings> get();
  Future<void> set(BrowseSettings settings);
  Future<void> reset();
}

final class SharedPreferencesBrowseSettingsRepository
    implements BrowseSettingsRepository {
  SharedPreferencesBrowseSettingsRepository();

  static String key = 'browse_settings';

  final _prefs = SharedPreferencesAsync();

  @override
  Future<BrowseSettings> get() {
    return _prefs.getString(key).then((value) {
      if (value == null) {
        return const BrowseSettings(
          hiddenPatterns: [
            '.*',
          ],
          showHidden: false,
          ignoreUploadPatterns: [
            '.DS_Store',
          ],
        );
      }
      return BrowseSettings.fromJson(jsonDecode(value) as Map<String, Object?>);
    });
  }

  @override
  Future<void> set(BrowseSettings settings) async {
    final json = settings.toJson();
    final jsonString = jsonEncode(json);
    await _prefs.setString(key, jsonString);
  }

  @override
  Future<void> reset() async {
    await _prefs.remove(key);
  }
}
