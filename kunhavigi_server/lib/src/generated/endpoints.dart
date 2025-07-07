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
import '../features/browse/browse_endpoint.dart' as _i2;
import '../features/transfer/transfer_endpoint.dart' as _i3;
import 'package:kunhavigi_shared/src/entry.dart' as _i4;
import 'dart:typed_data' as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'browse': _i2.BrowseEndpoint()
        ..initialize(
          server,
          'browse',
          null,
        ),
      'transfer': _i3.TransferEndpoint()
        ..initialize(
          server,
          'transfer',
          null,
        ),
    };
    connectors['browse'] = _i1.EndpointConnector(
      name: 'browse',
      endpoint: endpoints['browse']!,
      methodConnectors: {
        'getEntries': _i1.MethodConnector(
          name: 'getEntries',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['browse'] as _i2.BrowseEndpoint).getEntries(
            session,
            params['path'],
          ),
        ),
        'peekEntry': _i1.MethodConnector(
          name: 'peekEntry',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['browse'] as _i2.BrowseEndpoint).peekEntry(
            session,
            params['path'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['browse'] as _i2.BrowseEndpoint).delete(
            session,
            params['path'],
          ),
        ),
        'rename': _i1.MethodConnector(
          name: 'rename',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            ),
            'newName': _i1.ParameterDescription(
              name: 'newName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['browse'] as _i2.BrowseEndpoint).rename(
            session,
            path: params['path'],
            newName: params['newName'],
          ),
        ),
      },
    );
    connectors['transfer'] = _i1.EndpointConnector(
      name: 'transfer',
      endpoint: endpoints['transfer']!,
      methodConnectors: {
        'downloadFile': _i1.MethodStreamConnector(
          name: 'downloadFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            )
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['transfer'] as _i3.TransferEndpoint).downloadFile(
            session,
            params['path'],
          ),
        ),
        'uploadFile': _i1.MethodStreamConnector(
          name: 'uploadFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<_i4.RelativePath>(),
              nullable: false,
            )
          },
          streamParams: {
            'data': _i1.StreamParameterDescription<_i5.ByteData>(
              name: 'data',
              nullable: false,
            )
          },
          returnType: _i1.MethodStreamReturnType.futureType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['transfer'] as _i3.TransferEndpoint).uploadFile(
            session,
            path: params['path'],
            data: streamParams['data']!.cast<_i5.ByteData>(),
          ),
        ),
      },
    );
  }
}
