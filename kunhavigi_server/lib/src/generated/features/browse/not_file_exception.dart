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

abstract class NotFileException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  NotFileException._({required this.path});

  factory NotFileException({required String path}) = _NotFileExceptionImpl;

  factory NotFileException.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotFileException(path: jsonSerialization['path'] as String);
  }

  String path;

  /// Returns a shallow copy of this [NotFileException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotFileException copyWith({String? path});
  @override
  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {'path': path};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _NotFileExceptionImpl extends NotFileException {
  _NotFileExceptionImpl({required String path}) : super._(path: path);

  /// Returns a shallow copy of this [NotFileException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotFileException copyWith({String? path}) {
    return NotFileException(path: path ?? this.path);
  }
}
