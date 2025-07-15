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
import 'package:kunhavigi_shared/src/search_query.dart' as _i4;
import 'package:kunhavigi_shared/src/entry.dart' as _i5;
import 'package:kunhavigi_shared/src/entry_preview.dart' as _i6;
import 'dart:typed_data' as _i7;
import 'package:kunhavigi_shared/src/download_progress.dart' as _i8;
import 'package:kunhavigi_client/src/protocol/features/transfer/upload_progress.dart'
    as _i9;
import 'protocol.dart' as _i10;

/// {@category Endpoint}
class EndpointBrowse extends _i1.EndpointRef {
  EndpointBrowse(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'browse';

  /// Search entries (files and directories) by name under a given path, or globally if path is null.
  _i2.Future<_i3.EntriesResponse> searchEntries(_i4.SearchQuery query) =>
      caller.callServerEndpoint<_i3.EntriesResponse>(
        'browse',
        'searchEntries',
        {'query': query},
      );

  /// Get the list of entries (files and directories) in a given path.
  _i2.Future<_i3.EntriesResponse> getEntries(_i5.RelativePath path) =>
      caller.callServerEndpoint<_i3.EntriesResponse>(
        'browse',
        'getEntries',
        {'path': path},
      );

  /// Peek at the content of a file to generate a preview.
  _i2.Future<_i6.EntryPreview> peekEntry(_i5.RelativePath path) =>
      caller.callServerEndpoint<_i6.EntryPreview>(
        'browse',
        'peekEntry',
        {'path': path},
      );

  /// Delete a file from the server
  _i2.Future<bool> delete(_i5.RelativePath path) =>
      caller.callServerEndpoint<bool>(
        'browse',
        'delete',
        {'path': path},
      );

  /// Rename a file or directory on the server
  _i2.Future<_i5.Entry> rename({
    required _i5.RelativePath path,
    required String newName,
  }) =>
      caller.callServerEndpoint<_i5.Entry>(
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

  /// Download a file or folder from the server
  _i2.Stream<_i7.ByteData> downloadFile(_i5.RelativePath path) => caller
          .callStreamingServerEndpoint<_i2.Stream<_i7.ByteData>, _i7.ByteData>(
        'transfer',
        'downloadFile',
        {'path': path},
        {},
      );

  /// Get a download URL for a file or folder with progress updates
  /// Folders are zipped before download
  _i2.Stream<_i8.DownloadProgress> getDownloadUrl(_i5.RelativePath path) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i8.DownloadProgress>,
          _i8.DownloadProgress>(
        'transfer',
        'getDownloadUrl',
        {'path': path},
        {},
      );

  /// Upload a file to the server with progress updates
  _i2.Stream<_i9.UploadProgress> uploadFile({
    required _i5.RelativePath path,
    required _i2.Stream<_i7.ByteData> data,
  }) =>
      caller.callStreamingServerEndpoint<_i2.Stream<_i9.UploadProgress>,
          _i9.UploadProgress>(
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
          _i10.Protocol(),
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
