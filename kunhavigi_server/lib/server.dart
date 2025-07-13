import 'package:kunhavigi_server/src/features/future_call/cleanup_download.dart';
import 'package:kunhavigi_server/src/features/future_call/future_call_id.dart';
import 'package:kunhavigi_server/src/features/route/static_route.dart';
import 'package:kunhavigi_server/src/generated/endpoints.dart';
import 'package:kunhavigi_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

Future<void> run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Serve all files in the /static directory with CORS headers.
  pod.webServer.addRoute(
    StaticRoute(serverDirectory: 'static'),
    '/*',
  );

  // Start the server.
  await pod.start();

  pod.registerFutureCall(
    CleanupDownload(),
    FutureCallName.cleanupDownload.name,
  );
}
