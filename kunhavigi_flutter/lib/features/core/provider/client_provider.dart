import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse_settings/provider/settings_provider.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

part 'client_provider.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  final serverUrl = ref.watch(serverUrlProvider);
  final client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor();
  logger.i('Client initialized with server URL: $serverUrl');
  return client;
}

@Riverpod(keepAlive: true)
String serverUrl(Ref ref) {
  // When you are running the app on a physical device, you need to set the
  // server URL to the IP address of your computer. You can find the IP
  // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
  // You can set the variable when running or building your app like this:
  // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrlFromSettings =
      ref.watch(currentBrowseSettingsProvider).value?.serverUrl;

  if (serverUrlFromSettings != null && serverUrlFromSettings.isNotEmpty) {
    logger.i('Using server URL from settings: $serverUrlFromSettings');
    return serverUrlFromSettings;
  } else if (serverUrlFromEnv.isNotEmpty) {
    logger.i('Using server URL from environment: $serverUrlFromEnv');
    return serverUrlFromEnv;
  } else {
    logger.w('No server URL provided, using default localhost URL');
    return 'http://$localhost:8080/';
  }
}
