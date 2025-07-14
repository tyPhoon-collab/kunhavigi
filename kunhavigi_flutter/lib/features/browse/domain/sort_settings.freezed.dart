// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SortSettings {
  SortType get type;
  SortOrder get order;

  /// Create a copy of SortSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortSettingsCopyWith<SortSettings> get copyWith =>
      _$SortSettingsCopyWithImpl<SortSettings>(
          this as SortSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortSettings &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, order);

  @override
  String toString() {
    return 'SortSettings(type: $type, order: $order)';
  }
}

/// @nodoc
abstract mixin class $SortSettingsCopyWith<$Res> {
  factory $SortSettingsCopyWith(
          SortSettings value, $Res Function(SortSettings) _then) =
      _$SortSettingsCopyWithImpl;
  @useResult
  $Res call({SortType type, SortOrder order});
}

/// @nodoc
class _$SortSettingsCopyWithImpl<$Res> implements $SortSettingsCopyWith<$Res> {
  _$SortSettingsCopyWithImpl(this._self, this._then);

  final SortSettings _self;
  final $Res Function(SortSettings) _then;

  /// Create a copy of SortSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? order = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SortType,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ));
  }
}

/// Adds pattern-matching-related methods to [SortSettings].
extension SortSettingsPatterns on SortSettings {
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
    TResult Function(_SortSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SortSettings() when $default != null:
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
    TResult Function(_SortSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortSettings():
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
    TResult? Function(_SortSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortSettings() when $default != null:
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
    TResult Function(SortType type, SortOrder order)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SortSettings() when $default != null:
        return $default(_that.type, _that.order);
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
    TResult Function(SortType type, SortOrder order) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortSettings():
        return $default(_that.type, _that.order);
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
    TResult? Function(SortType type, SortOrder order)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SortSettings() when $default != null:
        return $default(_that.type, _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SortSettings extends SortSettings {
  const _SortSettings(
      {this.type = SortType.name, this.order = SortOrder.ascending})
      : super._();

  @override
  @JsonKey()
  final SortType type;
  @override
  @JsonKey()
  final SortOrder order;

  /// Create a copy of SortSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SortSettingsCopyWith<_SortSettings> get copyWith =>
      __$SortSettingsCopyWithImpl<_SortSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SortSettings &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, order);

  @override
  String toString() {
    return 'SortSettings(type: $type, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$SortSettingsCopyWith<$Res>
    implements $SortSettingsCopyWith<$Res> {
  factory _$SortSettingsCopyWith(
          _SortSettings value, $Res Function(_SortSettings) _then) =
      __$SortSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({SortType type, SortOrder order});
}

/// @nodoc
class __$SortSettingsCopyWithImpl<$Res>
    implements _$SortSettingsCopyWith<$Res> {
  __$SortSettingsCopyWithImpl(this._self, this._then);

  final _SortSettings _self;
  final $Res Function(_SortSettings) _then;

  /// Create a copy of SortSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? order = null,
  }) {
    return _then(_SortSettings(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SortType,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as SortOrder,
    ));
  }
}

// dart format on
