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

abstract class SearchedResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SearchedResponse._({
    required this.entries,
    required this.hasMore,
  });

  factory SearchedResponse({
    required List<_i2.Entry> entries,
    required bool hasMore,
  }) = _SearchedResponseImpl;

  factory SearchedResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchedResponse(
      entries: (jsonSerialization['entries'] as List)
          .map((e) => _i2.Entry.fromJson(e))
          .toList(),
      hasMore: jsonSerialization['hasMore'] as bool,
    );
  }

  List<_i2.Entry> entries;

  bool hasMore;

  /// Returns a shallow copy of this [SearchedResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchedResponse copyWith({
    List<_i2.Entry>? entries,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
      'hasMore': hasMore,
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
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SearchedResponseImpl extends SearchedResponse {
  _SearchedResponseImpl({
    required List<_i2.Entry> entries,
    required bool hasMore,
  }) : super._(
          entries: entries,
          hasMore: hasMore,
        );

  /// Returns a shallow copy of this [SearchedResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchedResponse copyWith({
    List<_i2.Entry>? entries,
    bool? hasMore,
  }) {
    return SearchedResponse(
      entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList(),
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
