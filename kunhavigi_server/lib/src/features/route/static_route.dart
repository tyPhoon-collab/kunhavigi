import 'dart:io';

import 'package:serverpod/serverpod.dart';

class StaticRoute extends RouteStaticDirectory {
  StaticRoute({required super.serverDirectory})
      : super(basePath: '/', serveAsRootPath: '/index.html');

  @override
  void setHeaders(HttpHeaders headers) {
    super.setHeaders(headers);
    headers
      ..add('Access-Control-Allow-Origin', '*')
      ..add('Access-Control-Allow-Methods', 'GET')
      ..add('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  }
}
