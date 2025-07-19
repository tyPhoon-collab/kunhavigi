// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$navigatorKeyHash() => r'e98ea9b83a531ebfa207927a585fc0549744a9c1';

/// See also [navigatorKey].
@ProviderFor(navigatorKey)
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>.internal(
  navigatorKey,
  name: r'navigatorKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$navigatorKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NavigatorKeyRef = ProviderRef<GlobalKey<NavigatorState>>;
String _$tellerHash() => r'e2c4b18a8d4a4167bd9901941b521bba08bcbb2e';

/// See also [teller].
@ProviderFor(teller)
final tellerProvider = AutoDisposeProvider<Teller>.internal(
  teller,
  name: r'tellerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tellerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TellerRef = AutoDisposeProviderRef<Teller>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
