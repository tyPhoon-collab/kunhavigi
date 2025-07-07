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
import 'package:kunhavigi_shared/src/entry.dart' as _i4;
import 'package:kunhavigi_shared/src/entry_preview.dart' as _i5;
import 'dart:typed_data' as _i6;
import 'protocol.dart' as _i7;

/// {@category Endpoint}
class EndpointBrowse extends _i1.EndpointRef {
  EndpointBrowse(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'browse';

  /// Get the list of entries (files and directories) in a given path.
  /// path is relative or absolute, but must be within the data directory.
  _i2.Future<_i3.EntriesResponse> getEntries(_i4.RelativePath path) =>
      caller.callServerEndpoint<_i3.EntriesResponse>(
        'browse',
        'getEntries',
        {'path': path},
      );

  /// Peek at the content of a file to generate a preview.
  _i2.Future<_i5.EntryPreview> peekEntry(_i4.RelativePath path) =>
      caller.callServerEndpoint<_i5.EntryPreview>(
        'browse',
        'peekEntry',
        {'path': path},
      );

  /// Delete a file from the server
  _i2.Future<bool> delete(_i4.RelativePath path) =>
      caller.callServerEndpoint<bool>(
        'browse',
        'delete',
        {'path': path},
      );

  /// Rename a file or directory on the server
  _i2.Future<_i4.Entry> rename({
    required _i4.RelativePath path,
    required String newName,
  }) =>
      caller.callServerEndpoint<_i4.Entry>(
        'browse',
        'rename',
        {
          'path': path,
          'newName': newName,
        },
      );
}

/// {@category Endpoint}
class EndpointTransfer extends _i1.EndpointRef {
  EndpointTransfer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transfer';

  /// Download a file from the server
  _i2.Stream<_i6.ByteData> downloadFile(_i4.RelativePath path) => caller
          .callStreamingServerEndpoint<_i2.Stream<_i6.ByteData>, _i6.ByteData>(
        'transfer',
        'downloadFile',
        {'path': path},
        {},
      );

  /// Upload a file to the server
  _i2.Future<_i4.Entry> uploadFile({
    required _i4.RelativePath path,
    required _i2.Stream<_i6.ByteData> data,
  }) =>
      caller.callStreamingServerEndpoint<_i2.Future<_i4.Entry>, _i4.Entry>(
        'transfer',
        'uploadFile',
        {'path': path},
        {'data': data},
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
          _i7.Protocol(),
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
    transfer = EndpointTransfer(this);
  }

  late final EndpointBrowse browse;

  late final EndpointTransfer transfer;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'browse': browse,
        'transfer': transfer,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
