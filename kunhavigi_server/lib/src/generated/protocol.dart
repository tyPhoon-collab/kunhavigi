/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'features/browse/not_exists_exception.dart' as _i3;
import 'features/browse/path_outside_exception.dart' as _i4;
import 'features/browse/entries_response.dart' as _i5;
import 'package:kunhavigi_shared/kunhavigi_shared.dart' as _i6;
export 'features/browse/not_exists_exception.dart';
export 'features/browse/path_outside_exception.dart';
export 'features/browse/entries_response.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    ..._i2.Protocol.targetTableDefinitions
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i3.NotExistsException) {
      return _i3.NotExistsException.fromJson(data) as T;
    }
    if (t == _i4.PathOutsideException) {
      return _i4.PathOutsideException.fromJson(data) as T;
    }
    if (t == _i5.EntriesResponse) {
      return _i5.EntriesResponse.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.NotExistsException?>()) {
      return (data != null ? _i3.NotExistsException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.PathOutsideException?>()) {
      return (data != null ? _i4.PathOutsideException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.EntriesResponse?>()) {
      return (data != null ? _i5.EntriesResponse.fromJson(data) : null) as T;
    }
    if (t == List<_i6.Entry>) {
      return (data as List).map((e) => deserialize<_i6.Entry>(e)).toList() as T;
    }
    if (t == _i6.Entry) {
      return _i6.Entry.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.Entry?>()) {
      return (data != null ? _i6.Entry.fromJson(data) : null) as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i6.Entry) {
      return 'Entry';
    }
    if (data is _i3.NotExistsException) {
      return 'NotExistsException';
    }
    if (data is _i4.PathOutsideException) {
      return 'PathOutsideException';
    }
    if (data is _i5.EntriesResponse) {
      return 'EntriesResponse';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
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
      return deserialize<_i6.Entry>(data['data']);
    }
    if (dataClassName == 'NotExistsException') {
      return deserialize<_i3.NotExistsException>(data['data']);
    }
    if (dataClassName == 'PathOutsideException') {
      return deserialize<_i4.PathOutsideException>(data['data']);
    }
    if (dataClassName == 'EntriesResponse') {
      return deserialize<_i5.EntriesResponse>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'kunhavigi';
}
