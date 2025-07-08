import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/features/browse/application/picker.dart';
import 'package:kunhavigi_flutter/features/browse/application/saver.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) {
  // When you are running the app on a physical device, you need to set the
  // server URL to the IP address of your computer. You can find the IP
  // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
  // You can set the variable when running or building your app like this:
  // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl =
      serverUrlFromEnv.isEmpty ? 'http://$localhost:8080/' : serverUrlFromEnv;

  logger.i('Connecting to server at $serverUrl');

  return Client(serverUrl)..connectivityMonitor = FlutterConnectivityMonitor();
}

@Riverpod(keepAlive: true)
Saver saver(Ref ref) {
  return const FileSaverSelectPlaceSaver();
}

@Riverpod(keepAlive: true)
Picker picker(Ref ref) {
  return FilePickerPicker();
}
