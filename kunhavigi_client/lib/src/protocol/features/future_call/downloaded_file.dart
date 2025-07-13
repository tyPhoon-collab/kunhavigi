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

abstract class DownloadedFile implements _i1.SerializableModel {
  DownloadedFile._({required this.path});

  factory DownloadedFile({required String path}) = _DownloadedFileImpl;

  factory DownloadedFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return DownloadedFile(path: jsonSerialization['path'] as String);
  }

  String path;

  /// Returns a shallow copy of this [DownloadedFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DownloadedFile copyWith({String? path});
  @override
  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DownloadedFileImpl extends DownloadedFile {
  _DownloadedFileImpl({required String path}) : super._(path: path);

  /// Returns a shallow copy of this [DownloadedFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DownloadedFile copyWith({String? path}) {
    return DownloadedFile(path: path ?? this.path);
  }
}
