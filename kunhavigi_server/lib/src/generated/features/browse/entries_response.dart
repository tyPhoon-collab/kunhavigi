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
import 'package:kunhavigi_shared/kunhavigi_shared.dart' as _i2;

abstract class EntriesResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  EntriesResponse._({
    required this.entries,
    required this.totalCount,
    required this.isRootDirectory,
  });

  factory EntriesResponse({
    required List<_i2.Entry> entries,
    required int totalCount,
    required bool isRootDirectory,
  }) = _EntriesResponseImpl;

  factory EntriesResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntriesResponse(
      entries: (jsonSerialization['entries'] as List)
          .map((e) => _i2.Entry.fromJson(e))
          .toList(),
      totalCount: jsonSerialization['totalCount'] as int,
      isRootDirectory: jsonSerialization['isRootDirectory'] as bool,
    );
  }

  List<_i2.Entry> entries;

  int totalCount;

  bool isRootDirectory;

  /// Returns a shallow copy of this [EntriesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntriesResponse copyWith({
    List<_i2.Entry>? entries,
    int? totalCount,
    bool? isRootDirectory,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
      'isRootDirectory': isRootDirectory,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'entries': entries.toJson(
          valueToJson: (v) =>
// ignore: unnecessary_type_check
              v is _i1.ProtocolSerialization
                  ? (v as _i1.ProtocolSerialization).toJsonForProtocol()
                  : v.toJson()),
      'totalCount': totalCount,
      'isRootDirectory': isRootDirectory,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EntriesResponseImpl extends EntriesResponse {
  _EntriesResponseImpl({
    required List<_i2.Entry> entries,
    required int totalCount,
    required bool isRootDirectory,
  }) : super._(
          entries: entries,
          totalCount: totalCount,
          isRootDirectory: isRootDirectory,
        );

  /// Returns a shallow copy of this [EntriesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntriesResponse copyWith({
    List<_i2.Entry>? entries,
    int? totalCount,
    bool? isRootDirectory,
  }) {
    return EntriesResponse(
      entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      isRootDirectory: isRootDirectory ?? this.isRootDirectory,
    );
  }
}
