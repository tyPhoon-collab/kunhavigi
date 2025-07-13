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

abstract class UploadProgress implements _i1.SerializableModel {
  UploadProgress._({
    required this.current,
    required this.isComplete,
  });

  factory UploadProgress({
    required int current,
    required bool isComplete,
  }) = _UploadProgressImpl;

  factory UploadProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return UploadProgress(
      current: jsonSerialization['current'] as int,
      isComplete: jsonSerialization['isComplete'] as bool,
    );
  }

  int current;

  bool isComplete;

  /// Returns a shallow copy of this [UploadProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UploadProgress copyWith({
    int? current,
    bool? isComplete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'isComplete': isComplete,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UploadProgressImpl extends UploadProgress {
  _UploadProgressImpl({
    required int current,
    required bool isComplete,
  }) : super._(
          current: current,
          isComplete: isComplete,
        );

  /// Returns a shallow copy of this [UploadProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UploadProgress copyWith({
    int? current,
    bool? isComplete,
  }) {
    return UploadProgress(
      current: current ?? this.current,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
