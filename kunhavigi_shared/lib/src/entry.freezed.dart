// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Entry _$EntryFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'file':
          return FileEntry.fromJson(
            json
          );
                case 'directory':
          return DirectoryEntry.fromJson(
            json
          );
                case 'unknown':
          return UnknownEntry.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Entry',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Entry {

 String get absolutePath; String get relativePath;
/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryCopyWith<Entry> get copyWith => _$EntryCopyWithImpl<Entry>(this as Entry, _$identity);

  /// Serializes this Entry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Entry&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,absolutePath,relativePath);

@override
String toString() {
  return 'Entry(absolutePath: $absolutePath, relativePath: $relativePath)';
}


}

/// @nodoc
abstract mixin class $EntryCopyWith<$Res>  {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) _then) = _$EntryCopyWithImpl;
@useResult
$Res call({
 String absolutePath, String relativePath
});




}
/// @nodoc
class _$EntryCopyWithImpl<$Res>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._self, this._then);

  final Entry _self;
  final $Res Function(Entry) _then;

/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? absolutePath = null,Object? relativePath = null,}) {
  return _then(_self.copyWith(
absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Entry].
extension EntryPatterns on Entry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FileEntry value)?  file,TResult Function( DirectoryEntry value)?  directory,TResult Function( UnknownEntry value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FileEntry() when file != null:
return file(_that);case DirectoryEntry() when directory != null:
return directory(_that);case UnknownEntry() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FileEntry value)  file,required TResult Function( DirectoryEntry value)  directory,required TResult Function( UnknownEntry value)  unknown,}){
final _that = this;
switch (_that) {
case FileEntry():
return file(_that);case DirectoryEntry():
return directory(_that);case UnknownEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FileEntry value)?  file,TResult? Function( DirectoryEntry value)?  directory,TResult? Function( UnknownEntry value)?  unknown,}){
final _that = this;
switch (_that) {
case FileEntry() when file != null:
return file(_that);case DirectoryEntry() when directory != null:
return directory(_that);case UnknownEntry() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String absolutePath,  String relativePath,  int size,  DateTime lastModifiedAt)?  file,TResult Function( String absolutePath,  String relativePath)?  directory,TResult Function( String absolutePath,  String relativePath)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FileEntry() when file != null:
return file(_that.absolutePath,_that.relativePath,_that.size,_that.lastModifiedAt);case DirectoryEntry() when directory != null:
return directory(_that.absolutePath,_that.relativePath);case UnknownEntry() when unknown != null:
return unknown(_that.absolutePath,_that.relativePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String absolutePath,  String relativePath,  int size,  DateTime lastModifiedAt)  file,required TResult Function( String absolutePath,  String relativePath)  directory,required TResult Function( String absolutePath,  String relativePath)  unknown,}) {final _that = this;
switch (_that) {
case FileEntry():
return file(_that.absolutePath,_that.relativePath,_that.size,_that.lastModifiedAt);case DirectoryEntry():
return directory(_that.absolutePath,_that.relativePath);case UnknownEntry():
return unknown(_that.absolutePath,_that.relativePath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String absolutePath,  String relativePath,  int size,  DateTime lastModifiedAt)?  file,TResult? Function( String absolutePath,  String relativePath)?  directory,TResult? Function( String absolutePath,  String relativePath)?  unknown,}) {final _that = this;
switch (_that) {
case FileEntry() when file != null:
return file(_that.absolutePath,_that.relativePath,_that.size,_that.lastModifiedAt);case DirectoryEntry() when directory != null:
return directory(_that.absolutePath,_that.relativePath);case UnknownEntry() when unknown != null:
return unknown(_that.absolutePath,_that.relativePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class FileEntry extends Entry {
  const FileEntry({required this.absolutePath, required this.relativePath, required this.size, required this.lastModifiedAt, final  String? $type}): $type = $type ?? 'file',super._();
  factory FileEntry.fromJson(Map<String, dynamic> json) => _$FileEntryFromJson(json);

@override final  String absolutePath;
@override final  String relativePath;
 final  int size;
 final  DateTime lastModifiedAt;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileEntryCopyWith<FileEntry> get copyWith => _$FileEntryCopyWithImpl<FileEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileEntry&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath)&&(identical(other.size, size) || other.size == size)&&(identical(other.lastModifiedAt, lastModifiedAt) || other.lastModifiedAt == lastModifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,absolutePath,relativePath,size,lastModifiedAt);

@override
String toString() {
  return 'Entry.file(absolutePath: $absolutePath, relativePath: $relativePath, size: $size, lastModifiedAt: $lastModifiedAt)';
}


}

/// @nodoc
abstract mixin class $FileEntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory $FileEntryCopyWith(FileEntry value, $Res Function(FileEntry) _then) = _$FileEntryCopyWithImpl;
@override @useResult
$Res call({
 String absolutePath, String relativePath, int size, DateTime lastModifiedAt
});




}
/// @nodoc
class _$FileEntryCopyWithImpl<$Res>
    implements $FileEntryCopyWith<$Res> {
  _$FileEntryCopyWithImpl(this._self, this._then);

  final FileEntry _self;
  final $Res Function(FileEntry) _then;

/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? absolutePath = null,Object? relativePath = null,Object? size = null,Object? lastModifiedAt = null,}) {
  return _then(FileEntry(
absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,lastModifiedAt: null == lastModifiedAt ? _self.lastModifiedAt : lastModifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DirectoryEntry extends Entry {
  const DirectoryEntry({required this.absolutePath, required this.relativePath, final  String? $type}): $type = $type ?? 'directory',super._();
  factory DirectoryEntry.fromJson(Map<String, dynamic> json) => _$DirectoryEntryFromJson(json);

@override final  String absolutePath;
@override final  String relativePath;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectoryEntryCopyWith<DirectoryEntry> get copyWith => _$DirectoryEntryCopyWithImpl<DirectoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DirectoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectoryEntry&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,absolutePath,relativePath);

@override
String toString() {
  return 'Entry.directory(absolutePath: $absolutePath, relativePath: $relativePath)';
}


}

/// @nodoc
abstract mixin class $DirectoryEntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory $DirectoryEntryCopyWith(DirectoryEntry value, $Res Function(DirectoryEntry) _then) = _$DirectoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String absolutePath, String relativePath
});




}
/// @nodoc
class _$DirectoryEntryCopyWithImpl<$Res>
    implements $DirectoryEntryCopyWith<$Res> {
  _$DirectoryEntryCopyWithImpl(this._self, this._then);

  final DirectoryEntry _self;
  final $Res Function(DirectoryEntry) _then;

/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? absolutePath = null,Object? relativePath = null,}) {
  return _then(DirectoryEntry(
absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UnknownEntry extends Entry {
  const UnknownEntry({required this.absolutePath, required this.relativePath, final  String? $type}): $type = $type ?? 'unknown',super._();
  factory UnknownEntry.fromJson(Map<String, dynamic> json) => _$UnknownEntryFromJson(json);

@override final  String absolutePath;
@override final  String relativePath;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownEntryCopyWith<UnknownEntry> get copyWith => _$UnknownEntryCopyWithImpl<UnknownEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnknownEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownEntry&&(identical(other.absolutePath, absolutePath) || other.absolutePath == absolutePath)&&(identical(other.relativePath, relativePath) || other.relativePath == relativePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,absolutePath,relativePath);

@override
String toString() {
  return 'Entry.unknown(absolutePath: $absolutePath, relativePath: $relativePath)';
}


}

/// @nodoc
abstract mixin class $UnknownEntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory $UnknownEntryCopyWith(UnknownEntry value, $Res Function(UnknownEntry) _then) = _$UnknownEntryCopyWithImpl;
@override @useResult
$Res call({
 String absolutePath, String relativePath
});




}
/// @nodoc
class _$UnknownEntryCopyWithImpl<$Res>
    implements $UnknownEntryCopyWith<$Res> {
  _$UnknownEntryCopyWithImpl(this._self, this._then);

  final UnknownEntry _self;
  final $Res Function(UnknownEntry) _then;

/// Create a copy of Entry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? absolutePath = null,Object? relativePath = null,}) {
  return _then(UnknownEntry(
absolutePath: null == absolutePath ? _self.absolutePath : absolutePath // ignore: cast_nullable_to_non_nullable
as String,relativePath: null == relativePath ? _self.relativePath : relativePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
