// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
DownloadProgress _$DownloadProgressFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'copying':
          return CopyingDownloadProgress.fromJson(
            json
          );
                case 'zipping':
          return ZippingDownloadProgress.fromJson(
            json
          );
                case 'completed':
          return CompletedDownloadProgress.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'DownloadProgress',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$DownloadProgress {



  /// Serializes this DownloadProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DownloadProgress);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DownloadProgress()';
}


}

/// @nodoc
class $DownloadProgressCopyWith<$Res>  {
$DownloadProgressCopyWith(DownloadProgress _, $Res Function(DownloadProgress) __);
}


/// Adds pattern-matching-related methods to [DownloadProgress].
extension DownloadProgressPatterns on DownloadProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CopyingDownloadProgress value)?  copying,TResult Function( ZippingDownloadProgress value)?  zipping,TResult Function( CompletedDownloadProgress value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CopyingDownloadProgress() when copying != null:
return copying(_that);case ZippingDownloadProgress() when zipping != null:
return zipping(_that);case CompletedDownloadProgress() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CopyingDownloadProgress value)  copying,required TResult Function( ZippingDownloadProgress value)  zipping,required TResult Function( CompletedDownloadProgress value)  completed,}){
final _that = this;
switch (_that) {
case CopyingDownloadProgress():
return copying(_that);case ZippingDownloadProgress():
return zipping(_that);case CompletedDownloadProgress():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CopyingDownloadProgress value)?  copying,TResult? Function( ZippingDownloadProgress value)?  zipping,TResult? Function( CompletedDownloadProgress value)?  completed,}){
final _that = this;
switch (_that) {
case CopyingDownloadProgress() when copying != null:
return copying(_that);case ZippingDownloadProgress() when zipping != null:
return zipping(_that);case CompletedDownloadProgress() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  copying,TResult Function()?  zipping,TResult Function( String downloadUrl)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CopyingDownloadProgress() when copying != null:
return copying();case ZippingDownloadProgress() when zipping != null:
return zipping();case CompletedDownloadProgress() when completed != null:
return completed(_that.downloadUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  copying,required TResult Function()  zipping,required TResult Function( String downloadUrl)  completed,}) {final _that = this;
switch (_that) {
case CopyingDownloadProgress():
return copying();case ZippingDownloadProgress():
return zipping();case CompletedDownloadProgress():
return completed(_that.downloadUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  copying,TResult? Function()?  zipping,TResult? Function( String downloadUrl)?  completed,}) {final _that = this;
switch (_that) {
case CopyingDownloadProgress() when copying != null:
return copying();case ZippingDownloadProgress() when zipping != null:
return zipping();case CompletedDownloadProgress() when completed != null:
return completed(_that.downloadUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CopyingDownloadProgress implements DownloadProgress {
  const CopyingDownloadProgress({final  String? $type}): $type = $type ?? 'copying';
  factory CopyingDownloadProgress.fromJson(Map<String, dynamic> json) => _$CopyingDownloadProgressFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$CopyingDownloadProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CopyingDownloadProgress);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DownloadProgress.copying()';
}


}




/// @nodoc
@JsonSerializable()

class ZippingDownloadProgress implements DownloadProgress {
  const ZippingDownloadProgress({final  String? $type}): $type = $type ?? 'zipping';
  factory ZippingDownloadProgress.fromJson(Map<String, dynamic> json) => _$ZippingDownloadProgressFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ZippingDownloadProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZippingDownloadProgress);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DownloadProgress.zipping()';
}


}




/// @nodoc
@JsonSerializable()

class CompletedDownloadProgress implements DownloadProgress {
  const CompletedDownloadProgress({required this.downloadUrl, final  String? $type}): $type = $type ?? 'completed';
  factory CompletedDownloadProgress.fromJson(Map<String, dynamic> json) => _$CompletedDownloadProgressFromJson(json);

 final  String downloadUrl;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of DownloadProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletedDownloadProgressCopyWith<CompletedDownloadProgress> get copyWith => _$CompletedDownloadProgressCopyWithImpl<CompletedDownloadProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompletedDownloadProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompletedDownloadProgress&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,downloadUrl);

@override
String toString() {
  return 'DownloadProgress.completed(downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $CompletedDownloadProgressCopyWith<$Res> implements $DownloadProgressCopyWith<$Res> {
  factory $CompletedDownloadProgressCopyWith(CompletedDownloadProgress value, $Res Function(CompletedDownloadProgress) _then) = _$CompletedDownloadProgressCopyWithImpl;
@useResult
$Res call({
 String downloadUrl
});




}
/// @nodoc
class _$CompletedDownloadProgressCopyWithImpl<$Res>
    implements $CompletedDownloadProgressCopyWith<$Res> {
  _$CompletedDownloadProgressCopyWithImpl(this._self, this._then);

  final CompletedDownloadProgress _self;
  final $Res Function(CompletedDownloadProgress) _then;

/// Create a copy of DownloadProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? downloadUrl = null,}) {
  return _then(CompletedDownloadProgress(
downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
