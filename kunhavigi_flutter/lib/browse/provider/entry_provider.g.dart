// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesHash() => r'f5b44c836cf5c31bbb36a20fe26a9841e9b27f92';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [entries].
@ProviderFor(entries)
const entriesProvider = EntriesFamily();

/// See also [entries].
class EntriesFamily extends Family<AsyncValue<List<Entry>>> {
  /// See also [entries].
  const EntriesFamily();

  /// See also [entries].
  EntriesProvider call(
    String path,
  ) {
    return EntriesProvider(
      path,
    );
  }

  @override
  EntriesProvider getProviderOverride(
    covariant EntriesProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'entriesProvider';
}

/// See also [entries].
class EntriesProvider extends AutoDisposeFutureProvider<List<Entry>> {
  /// See also [entries].
  EntriesProvider(
    String path,
  ) : this._internal(
          (ref) => entries(
            ref as EntriesRef,
            path,
          ),
          from: entriesProvider,
          name: r'entriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$entriesHash,
          dependencies: EntriesFamily._dependencies,
          allTransitiveDependencies: EntriesFamily._allTransitiveDependencies,
          path: path,
        );

  EntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    FutureOr<List<Entry>> Function(EntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EntriesProvider._internal(
        (ref) => create(ref as EntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Entry>> createElement() {
    return _EntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntriesProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EntriesRef on AutoDisposeFutureProviderRef<List<Entry>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _EntriesProviderElement
    extends AutoDisposeFutureProviderElement<List<Entry>> with EntriesRef {
  _EntriesProviderElement(super.provider);

  @override
  String get path => (origin as EntriesProvider).path;
}

String _$pathHash() => r'a6ab0a56969819473572d62e1c2df2a3c505017f';

/// See also [Path].
@ProviderFor(Path)
final pathProvider = NotifierProvider<Path, String>.internal(
  Path.new,
  name: r'pathProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Path = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
