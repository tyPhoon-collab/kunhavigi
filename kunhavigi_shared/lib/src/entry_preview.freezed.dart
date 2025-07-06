// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
EntryPreview _$EntryPreviewFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'text':
          return TextEntryPreview.fromJson(
            json
          );
                case 'image':
          return ImageEntryPreview.fromJson(
            json
          );
                case 'unknown':
          return UnknownEntryPreview.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EntryPreview',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$EntryPreview {



  /// Serializes this EntryPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryPreview);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryPreview()';
}


}

/// @nodoc
class $EntryPreviewCopyWith<$Res>  {
$EntryPreviewCopyWith(EntryPreview _, $Res Function(EntryPreview) __);
}


/// Adds pattern-matching-related methods to [EntryPreview].
extension EntryPreviewPatterns on EntryPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TextEntryPreview value)?  text,TResult Function( ImageEntryPreview value)?  image,TResult Function( UnknownEntryPreview value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TextEntryPreview() when text != null:
return text(_that);case ImageEntryPreview() when image != null:
return image(_that);case UnknownEntryPreview() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TextEntryPreview value)  text,required TResult Function( ImageEntryPreview value)  image,required TResult Function( UnknownEntryPreview value)  unknown,}){
final _that = this;
switch (_that) {
case TextEntryPreview():
return text(_that);case ImageEntryPreview():
return image(_that);case UnknownEntryPreview():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TextEntryPreview value)?  text,TResult? Function( ImageEntryPreview value)?  image,TResult? Function( UnknownEntryPreview value)?  unknown,}){
final _that = this;
switch (_that) {
case TextEntryPreview() when text != null:
return text(_that);case ImageEntryPreview() when image != null:
return image(_that);case UnknownEntryPreview() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  text,TResult Function(@BytesToBase64Converter()  Uint8List base64)?  image,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TextEntryPreview() when text != null:
return text(_that.text);case ImageEntryPreview() when image != null:
return image(_that.base64);case UnknownEntryPreview() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  text,required TResult Function(@BytesToBase64Converter()  Uint8List base64)  image,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case TextEntryPreview():
return text(_that.text);case ImageEntryPreview():
return image(_that.base64);case UnknownEntryPreview():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  text,TResult? Function(@BytesToBase64Converter()  Uint8List base64)?  image,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case TextEntryPreview() when text != null:
return text(_that.text);case ImageEntryPreview() when image != null:
return image(_that.base64);case UnknownEntryPreview() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TextEntryPreview implements EntryPreview {
  const TextEntryPreview({required this.text, final  String? $type}): $type = $type ?? 'text';
  factory TextEntryPreview.fromJson(Map<String, dynamic> json) => _$TextEntryPreviewFromJson(json);

 final  String text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EntryPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextEntryPreviewCopyWith<TextEntryPreview> get copyWith => _$TextEntryPreviewCopyWithImpl<TextEntryPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextEntryPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextEntryPreview&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'EntryPreview.text(text: $text)';
}


}

/// @nodoc
abstract mixin class $TextEntryPreviewCopyWith<$Res> implements $EntryPreviewCopyWith<$Res> {
  factory $TextEntryPreviewCopyWith(TextEntryPreview value, $Res Function(TextEntryPreview) _then) = _$TextEntryPreviewCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$TextEntryPreviewCopyWithImpl<$Res>
    implements $TextEntryPreviewCopyWith<$Res> {
  _$TextEntryPreviewCopyWithImpl(this._self, this._then);

  final TextEntryPreview _self;
  final $Res Function(TextEntryPreview) _then;

/// Create a copy of EntryPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(TextEntryPreview(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ImageEntryPreview implements EntryPreview {
  const ImageEntryPreview({@BytesToBase64Converter() required this.base64, final  String? $type}): $type = $type ?? 'image';
  factory ImageEntryPreview.fromJson(Map<String, dynamic> json) => _$ImageEntryPreviewFromJson(json);

@BytesToBase64Converter() final  Uint8List base64;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EntryPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageEntryPreviewCopyWith<ImageEntryPreview> get copyWith => _$ImageEntryPreviewCopyWithImpl<ImageEntryPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageEntryPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageEntryPreview&&const DeepCollectionEquality().equals(other.base64, base64));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(base64));

@override
String toString() {
  return 'EntryPreview.image(base64: $base64)';
}


}

/// @nodoc
abstract mixin class $ImageEntryPreviewCopyWith<$Res> implements $EntryPreviewCopyWith<$Res> {
  factory $ImageEntryPreviewCopyWith(ImageEntryPreview value, $Res Function(ImageEntryPreview) _then) = _$ImageEntryPreviewCopyWithImpl;
@useResult
$Res call({
@BytesToBase64Converter() Uint8List base64
});




}
/// @nodoc
class _$ImageEntryPreviewCopyWithImpl<$Res>
    implements $ImageEntryPreviewCopyWith<$Res> {
  _$ImageEntryPreviewCopyWithImpl(this._self, this._then);

  final ImageEntryPreview _self;
  final $Res Function(ImageEntryPreview) _then;

/// Create a copy of EntryPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? base64 = null,}) {
  return _then(ImageEntryPreview(
base64: null == base64 ? _self.base64 : base64 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnknownEntryPreview implements EntryPreview {
  const UnknownEntryPreview({final  String? $type}): $type = $type ?? 'unknown';
  factory UnknownEntryPreview.fromJson(Map<String, dynamic> json) => _$UnknownEntryPreviewFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UnknownEntryPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownEntryPreview);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EntryPreview.unknown()';
}


}




// dart format on
