/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'features/browse/entries_response.dart' as _i2;
import 'features/browse/not_directory_exception.dart' as _i3;
import 'features/browse/not_exists_exception.dart' as _i4;
import 'features/browse/not_file_exception.dart' as _i5;
import 'features/browse/path_outside_exception.dart' as _i6;
import 'package:kunhavigi_shared/kunhavigi_shared.dart' as _i7;
export 'features/browse/entries_response.dart';
export 'features/browse/not_directory_exception.dart';
export 'features/browse/not_exists_exception.dart';
export 'features/browse/not_file_exception.dart';
export 'features/browse/path_outside_exception.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.EntriesResponse) {
      return _i2.EntriesResponse.fromJson(data) as T;
    }
    if (t == _i3.NotDirectoryException) {
      return _i3.NotDirectoryException.fromJson(data) as T;
    }
    if (t == _i4.NotExistsException) {
      return _i4.NotExistsException.fromJson(data) as T;
    }
    if (t == _i5.NotFileException) {
      return _i5.NotFileException.fromJson(data) as T;
    }
    if (t == _i6.PathOutsideException) {
      return _i6.PathOutsideException.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.EntriesResponse?>()) {
      return (data != null ? _i2.EntriesResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.NotDirectoryException?>()) {
      return (data != null ? _i3.NotDirectoryException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.NotExistsException?>()) {
      return (data != null ? _i4.NotExistsException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.NotFileException?>()) {
      return (data != null ? _i5.NotFileException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PathOutsideException?>()) {
      return (data != null ? _i6.PathOutsideException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i7.Entry>) {
      return (data as List).map((e) => deserialize<_i7.Entry>(e)).toList() as T;
    }
    if (t == _i7.Entry) {
      return _i7.Entry.fromJson(data) as T;
    }
    if (t == _i7.FileEntry) {
      return _i7.FileEntry.fromJson(data) as T;
    }
    if (t == _i7.EntryPreview) {
      return _i7.EntryPreview.fromJson(data) as T;
    }
    if (t == _i1.getType<_i7.Entry?>()) {
      return (data != null ? _i7.Entry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.FileEntry?>()) {
      return (data != null ? _i7.FileEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.EntryPreview?>()) {
      return (data != null ? _i7.EntryPreview.fromJson(data) : null) as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i7.Entry) {
      return 'Entry';
    }
    if (data is _i7.FileEntry) {
      return 'FileEntry';
    }
    if (data is _i7.EntryPreview) {
      return 'EntryPreview';
    }
    if (data is _i2.EntriesResponse) {
      return 'EntriesResponse';
    }
    if (data is _i3.NotDirectoryException) {
      return 'NotDirectoryException';
    }
    if (data is _i4.NotExistsException) {
      return 'NotExistsException';
    }
    if (data is _i5.NotFileException) {
      return 'NotFileException';
    }
    if (data is _i6.PathOutsideException) {
      return 'PathOutsideException';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Entry') {
      return deserialize<_i7.Entry>(data['data']);
    }
    if (dataClassName == 'FileEntry') {
      return deserialize<_i7.FileEntry>(data['data']);
    }
    if (dataClassName == 'EntryPreview') {
      return deserialize<_i7.EntryPreview>(data['data']);
    }
    if (dataClassName == 'EntriesResponse') {
      return deserialize<_i2.EntriesResponse>(data['data']);
    }
    if (dataClassName == 'NotDirectoryException') {
      return deserialize<_i3.NotDirectoryException>(data['data']);
    }
    if (dataClassName == 'NotExistsException') {
      return deserialize<_i4.NotExistsException>(data['data']);
    }
    if (dataClassName == 'NotFileException') {
      return deserialize<_i5.NotFileException>(data['data']);
    }
    if (dataClassName == 'PathOutsideException') {
      return deserialize<_i6.PathOutsideException>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
