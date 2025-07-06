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
import 'dart:async' as _i2;
import 'package:kunhavigi_client/src/protocol/features/browse/entries_response.dart'
    as _i3;
import 'package:kunhavigi_shared/src/entry_preview.dart' as _i4;
import 'protocol.dart' as _i5;

/// {@category Endpoint}
class EndpointBrowse extends _i1.EndpointRef {
  EndpointBrowse(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'browse';

  /// 相対パスと絶対パスを許容する
  _i2.Future<_i3.EntriesResponse> getEntries(String path) =>
      caller.callServerEndpoint<_i3.EntriesResponse>(
        'browse',
        'getEntries',
        {'path': path},
      );

  /// プレビュー
  _i2.Future<_i4.EntryPreview> peekEntry(String path) =>
      caller.callServerEndpoint<_i4.EntryPreview>(
        'browse',
        'peekEntry',
        {'path': path},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i5.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    browse = EndpointBrowse(this);
  }

  late final EndpointBrowse browse;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'browse': browse};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
