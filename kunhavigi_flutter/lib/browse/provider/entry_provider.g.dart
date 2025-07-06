// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesHash() => r'4e4fccd2bc72f259fb5ebe8c43e2c4dfe8aed084';

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
class EntriesFamily extends Family<AsyncValue<EntriesResponse>> {
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
class EntriesProvider extends FutureProvider<EntriesResponse> {
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
    FutureOr<EntriesResponse> Function(EntriesRef provider) create,
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
  FutureProviderElement<EntriesResponse> createElement() {
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
mixin EntriesRef on FutureProviderRef<EntriesResponse> {
  /// The parameter `path` of this provider.
  String get path;
}

class _EntriesProviderElement extends FutureProviderElement<EntriesResponse>
    with EntriesRef {
  _EntriesProviderElement(super.provider);

  @override
  String get path => (origin as EntriesProvider).path;
}

String _$entryPreviewHash() => r'dbcffab4fb23676f9b9d33bd369aaa18f8c16e4a';

/// See also [entryPreview].
@ProviderFor(entryPreview)
const entryPreviewProvider = EntryPreviewFamily();

/// See also [entryPreview].
class EntryPreviewFamily extends Family<AsyncValue<EntryPreview>> {
  /// See also [entryPreview].
  const EntryPreviewFamily();

  /// See also [entryPreview].
  EntryPreviewProvider call(
    String path,
  ) {
    return EntryPreviewProvider(
      path,
    );
  }

  @override
  EntryPreviewProvider getProviderOverride(
    covariant EntryPreviewProvider provider,
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
  String? get name => r'entryPreviewProvider';
}

/// See also [entryPreview].
class EntryPreviewProvider extends FutureProvider<EntryPreview> {
  /// See also [entryPreview].
  EntryPreviewProvider(
    String path,
  ) : this._internal(
          (ref) => entryPreview(
            ref as EntryPreviewRef,
            path,
          ),
          from: entryPreviewProvider,
          name: r'entryPreviewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$entryPreviewHash,
          dependencies: EntryPreviewFamily._dependencies,
          allTransitiveDependencies:
              EntryPreviewFamily._allTransitiveDependencies,
          path: path,
        );

  EntryPreviewProvider._internal(
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
    FutureOr<EntryPreview> Function(EntryPreviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EntryPreviewProvider._internal(
        (ref) => create(ref as EntryPreviewRef),
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
  FutureProviderElement<EntryPreview> createElement() {
    return _EntryPreviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EntryPreviewProvider && other.path == path;
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
mixin EntryPreviewRef on FutureProviderRef<EntryPreview> {
  /// The parameter `path` of this provider.
  String get path;
}

class _EntryPreviewProviderElement extends FutureProviderElement<EntryPreview>
    with EntryPreviewRef {
  _EntryPreviewProviderElement(super.provider);

  @override
  String get path => (origin as EntryPreviewProvider).path;
}

String _$pathHash() => r'2448b7c8cd2d1e451a55000e0ae251c4245267ea';

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
