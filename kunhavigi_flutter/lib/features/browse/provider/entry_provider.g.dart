// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$entriesHash() => r'75b899cae0687f4df32a23b567e1135a7c8817ad';

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
    RelativePath path,
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
    RelativePath path,
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

  final RelativePath path;

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
  RelativePath get path;
}

class _EntriesProviderElement extends FutureProviderElement<EntriesResponse>
    with EntriesRef {
  _EntriesProviderElement(super.provider);

  @override
  RelativePath get path => (origin as EntriesProvider).path;
}

String _$filteredEntriesHash() => r'70752b56b47d674f6b5dc460791b85f3aab20f06';

/// See also [filteredEntries].
@ProviderFor(filteredEntries)
const filteredEntriesProvider = FilteredEntriesFamily();

/// See also [filteredEntries].
class FilteredEntriesFamily extends Family<AsyncValue<EntriesResponse>> {
  /// See also [filteredEntries].
  const FilteredEntriesFamily();

  /// See also [filteredEntries].
  FilteredEntriesProvider call(
    RelativePath path,
  ) {
    return FilteredEntriesProvider(
      path,
    );
  }

  @override
  FilteredEntriesProvider getProviderOverride(
    covariant FilteredEntriesProvider provider,
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
  String? get name => r'filteredEntriesProvider';
}

/// See also [filteredEntries].
class FilteredEntriesProvider extends FutureProvider<EntriesResponse> {
  /// See also [filteredEntries].
  FilteredEntriesProvider(
    RelativePath path,
  ) : this._internal(
          (ref) => filteredEntries(
            ref as FilteredEntriesRef,
            path,
          ),
          from: filteredEntriesProvider,
          name: r'filteredEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredEntriesHash,
          dependencies: FilteredEntriesFamily._dependencies,
          allTransitiveDependencies:
              FilteredEntriesFamily._allTransitiveDependencies,
          path: path,
        );

  FilteredEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final RelativePath path;

  @override
  Override overrideWith(
    FutureOr<EntriesResponse> Function(FilteredEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredEntriesProvider._internal(
        (ref) => create(ref as FilteredEntriesRef),
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
    return _FilteredEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredEntriesProvider && other.path == path;
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
mixin FilteredEntriesRef on FutureProviderRef<EntriesResponse> {
  /// The parameter `path` of this provider.
  RelativePath get path;
}

class _FilteredEntriesProviderElement
    extends FutureProviderElement<EntriesResponse> with FilteredEntriesRef {
  _FilteredEntriesProviderElement(super.provider);

  @override
  RelativePath get path => (origin as FilteredEntriesProvider).path;
}

String _$searchedEntriesHash() => r'4a14e1097df24e55f9c61b94af7031e2066993fe';

/// See also [searchedEntries].
@ProviderFor(searchedEntries)
const searchedEntriesProvider = SearchedEntriesFamily();

/// See also [searchedEntries].
class SearchedEntriesFamily extends Family<AsyncValue<EntriesResponse>> {
  /// See also [searchedEntries].
  const SearchedEntriesFamily();

  /// See also [searchedEntries].
  SearchedEntriesProvider call(
    SearchQuery query,
  ) {
    return SearchedEntriesProvider(
      query,
    );
  }

  @override
  SearchedEntriesProvider getProviderOverride(
    covariant SearchedEntriesProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'searchedEntriesProvider';
}

/// See also [searchedEntries].
class SearchedEntriesProvider extends FutureProvider<EntriesResponse> {
  /// See also [searchedEntries].
  SearchedEntriesProvider(
    SearchQuery query,
  ) : this._internal(
          (ref) => searchedEntries(
            ref as SearchedEntriesRef,
            query,
          ),
          from: searchedEntriesProvider,
          name: r'searchedEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchedEntriesHash,
          dependencies: SearchedEntriesFamily._dependencies,
          allTransitiveDependencies:
              SearchedEntriesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchedEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final SearchQuery query;

  @override
  Override overrideWith(
    FutureOr<EntriesResponse> Function(SearchedEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchedEntriesProvider._internal(
        (ref) => create(ref as SearchedEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  FutureProviderElement<EntriesResponse> createElement() {
    return _SearchedEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedEntriesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchedEntriesRef on FutureProviderRef<EntriesResponse> {
  /// The parameter `query` of this provider.
  SearchQuery get query;
}

class _SearchedEntriesProviderElement
    extends FutureProviderElement<EntriesResponse> with SearchedEntriesRef {
  _SearchedEntriesProviderElement(super.provider);

  @override
  SearchQuery get query => (origin as SearchedEntriesProvider).query;
}

String _$entryPreviewHash() => r'8d4d2a834f8abfdaf0506ebd325261b33e068f4b';

/// See also [entryPreview].
@ProviderFor(entryPreview)
const entryPreviewProvider = EntryPreviewFamily();

/// See also [entryPreview].
class EntryPreviewFamily extends Family<AsyncValue<EntryPreview>> {
  /// See also [entryPreview].
  const EntryPreviewFamily();

  /// See also [entryPreview].
  EntryPreviewProvider call(
    RelativePath path,
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
    RelativePath path,
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

  final RelativePath path;

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
  RelativePath get path;
}

class _EntryPreviewProviderElement extends FutureProviderElement<EntryPreview>
    with EntryPreviewRef {
  _EntryPreviewProviderElement(super.provider);

  @override
  RelativePath get path => (origin as EntryPreviewProvider).path;
}

String _$currentPathHash() => r'5daefd505aac78e067b5ea1386daf2aae121f246';

/// See also [CurrentPath].
@ProviderFor(CurrentPath)
final currentPathProvider =
    NotifierProvider<CurrentPath, RelativePath>.internal(
  CurrentPath.new,
  name: r'currentPathProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentPathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPath = Notifier<RelativePath>;
String _$currentSortSettingsHash() =>
    r'6c4067b62f40de9ce3eaa873015f563f643d9d55';

/// See also [CurrentSortSettings].
@ProviderFor(CurrentSortSettings)
final currentSortSettingsProvider =
    NotifierProvider<CurrentSortSettings, SortSettings>.internal(
  CurrentSortSettings.new,
  name: r'currentSortSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSortSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSortSettings = Notifier<SortSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
