// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browse_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrowseSettings {
  String? get serverUrl;
  String? get token;
  List<String>? get hiddenPatterns;
  bool? get showHidden;
  List<String>? get ignoreUploadPatterns;

  /// Create a copy of BrowseSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrowseSettingsCopyWith<BrowseSettings> get copyWith =>
      _$BrowseSettingsCopyWithImpl<BrowseSettings>(
          this as BrowseSettings, _$identity);

  /// Serializes this BrowseSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrowseSettings &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl) &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality()
                .equals(other.hiddenPatterns, hiddenPatterns) &&
            (identical(other.showHidden, showHidden) ||
                other.showHidden == showHidden) &&
            const DeepCollectionEquality()
                .equals(other.ignoreUploadPatterns, ignoreUploadPatterns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serverUrl,
      token,
      const DeepCollectionEquality().hash(hiddenPatterns),
      showHidden,
      const DeepCollectionEquality().hash(ignoreUploadPatterns));

  @override
  String toString() {
    return 'BrowseSettings(serverUrl: $serverUrl, token: $token, hiddenPatterns: $hiddenPatterns, showHidden: $showHidden, ignoreUploadPatterns: $ignoreUploadPatterns)';
  }
}

/// @nodoc
abstract mixin class $BrowseSettingsCopyWith<$Res> {
  factory $BrowseSettingsCopyWith(
          BrowseSettings value, $Res Function(BrowseSettings) _then) =
      _$BrowseSettingsCopyWithImpl;
  @useResult
  $Res call(
      {String? serverUrl,
      String? token,
      List<String>? hiddenPatterns,
      bool? showHidden,
      List<String>? ignoreUploadPatterns});
}

/// @nodoc
class _$BrowseSettingsCopyWithImpl<$Res>
    implements $BrowseSettingsCopyWith<$Res> {
  _$BrowseSettingsCopyWithImpl(this._self, this._then);

  final BrowseSettings _self;
  final $Res Function(BrowseSettings) _then;

  /// Create a copy of BrowseSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverUrl = freezed,
    Object? token = freezed,
    Object? hiddenPatterns = freezed,
    Object? showHidden = freezed,
    Object? ignoreUploadPatterns = freezed,
  }) {
    return _then(_self.copyWith(
      serverUrl: freezed == serverUrl
          ? _self.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      hiddenPatterns: freezed == hiddenPatterns
          ? _self.hiddenPatterns
          : hiddenPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      showHidden: freezed == showHidden
          ? _self.showHidden
          : showHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      ignoreUploadPatterns: freezed == ignoreUploadPatterns
          ? _self.ignoreUploadPatterns
          : ignoreUploadPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrowseSettings].
extension BrowseSettingsPatterns on BrowseSettings {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BrowseSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BrowseSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BrowseSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? serverUrl,
            String? token,
            List<String>? hiddenPatterns,
            bool? showHidden,
            List<String>? ignoreUploadPatterns)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings() when $default != null:
        return $default(_that.serverUrl, _that.token, _that.hiddenPatterns,
            _that.showHidden, _that.ignoreUploadPatterns);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? serverUrl,
            String? token,
            List<String>? hiddenPatterns,
            bool? showHidden,
            List<String>? ignoreUploadPatterns)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings():
        return $default(_that.serverUrl, _that.token, _that.hiddenPatterns,
            _that.showHidden, _that.ignoreUploadPatterns);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? serverUrl,
            String? token,
            List<String>? hiddenPatterns,
            bool? showHidden,
            List<String>? ignoreUploadPatterns)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrowseSettings() when $default != null:
        return $default(_that.serverUrl, _that.token, _that.hiddenPatterns,
            _that.showHidden, _that.ignoreUploadPatterns);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrowseSettings extends BrowseSettings {
  const _BrowseSettings(
      {this.serverUrl,
      this.token,
      final List<String>? hiddenPatterns,
      this.showHidden,
      final List<String>? ignoreUploadPatterns})
      : _hiddenPatterns = hiddenPatterns,
        _ignoreUploadPatterns = ignoreUploadPatterns,
        super._();
  factory _BrowseSettings.fromJson(Map<String, dynamic> json) =>
      _$BrowseSettingsFromJson(json);

  @override
  final String? serverUrl;
  @override
  final String? token;
  final List<String>? _hiddenPatterns;
  @override
  List<String>? get hiddenPatterns {
    final value = _hiddenPatterns;
    if (value == null) return null;
    if (_hiddenPatterns is EqualUnmodifiableListView) return _hiddenPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? showHidden;
  final List<String>? _ignoreUploadPatterns;
  @override
  List<String>? get ignoreUploadPatterns {
    final value = _ignoreUploadPatterns;
    if (value == null) return null;
    if (_ignoreUploadPatterns is EqualUnmodifiableListView)
      return _ignoreUploadPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of BrowseSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrowseSettingsCopyWith<_BrowseSettings> get copyWith =>
      __$BrowseSettingsCopyWithImpl<_BrowseSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrowseSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrowseSettings &&
            (identical(other.serverUrl, serverUrl) ||
                other.serverUrl == serverUrl) &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality()
                .equals(other._hiddenPatterns, _hiddenPatterns) &&
            (identical(other.showHidden, showHidden) ||
                other.showHidden == showHidden) &&
            const DeepCollectionEquality()
                .equals(other._ignoreUploadPatterns, _ignoreUploadPatterns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serverUrl,
      token,
      const DeepCollectionEquality().hash(_hiddenPatterns),
      showHidden,
      const DeepCollectionEquality().hash(_ignoreUploadPatterns));

  @override
  String toString() {
    return 'BrowseSettings(serverUrl: $serverUrl, token: $token, hiddenPatterns: $hiddenPatterns, showHidden: $showHidden, ignoreUploadPatterns: $ignoreUploadPatterns)';
  }
}

/// @nodoc
abstract mixin class _$BrowseSettingsCopyWith<$Res>
    implements $BrowseSettingsCopyWith<$Res> {
  factory _$BrowseSettingsCopyWith(
          _BrowseSettings value, $Res Function(_BrowseSettings) _then) =
      __$BrowseSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? serverUrl,
      String? token,
      List<String>? hiddenPatterns,
      bool? showHidden,
      List<String>? ignoreUploadPatterns});
}

/// @nodoc
class __$BrowseSettingsCopyWithImpl<$Res>
    implements _$BrowseSettingsCopyWith<$Res> {
  __$BrowseSettingsCopyWithImpl(this._self, this._then);

  final _BrowseSettings _self;
  final $Res Function(_BrowseSettings) _then;

  /// Create a copy of BrowseSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? serverUrl = freezed,
    Object? token = freezed,
    Object? hiddenPatterns = freezed,
    Object? showHidden = freezed,
    Object? ignoreUploadPatterns = freezed,
  }) {
    return _then(_BrowseSettings(
      serverUrl: freezed == serverUrl
          ? _self.serverUrl
          : serverUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      hiddenPatterns: freezed == hiddenPatterns
          ? _self._hiddenPatterns
          : hiddenPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      showHidden: freezed == showHidden
          ? _self.showHidden
          : showHidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      ignoreUploadPatterns: freezed == ignoreUploadPatterns
          ? _self._ignoreUploadPatterns
          : ignoreUploadPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

// dart format on
