// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$browseSettingsRepositoryHash() =>
    r'db8c45c634fd4828f30e305b6cb2e4e0c8a0535d';

/// See also [_browseSettingsRepository].
@ProviderFor(_browseSettingsRepository)
final _browseSettingsRepositoryProvider =
    Provider<SharedPreferencesBrowseSettingsRepository>.internal(
  _browseSettingsRepository,
  name: r'_browseSettingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$browseSettingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _BrowseSettingsRepositoryRef
    = ProviderRef<SharedPreferencesBrowseSettingsRepository>;
String _$currentBrowseSettingsHash() =>
    r'c33d4a6fe8012fdf9ada22f0cd5d6fe6c37a21e4';

/// See also [CurrentBrowseSettings].
@ProviderFor(CurrentBrowseSettings)
final currentBrowseSettingsProvider =
    AsyncNotifierProvider<CurrentBrowseSettings, BrowseSettings>.internal(
  CurrentBrowseSettings.new,
  name: r'currentBrowseSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentBrowseSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentBrowseSettings = AsyncNotifier<BrowseSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
