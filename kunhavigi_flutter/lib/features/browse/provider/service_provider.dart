import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/application/picker.dart';
import 'package:kunhavigi_flutter/features/browse/application/saver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
Saver saver(Ref ref) {
  return const FileSaverSelectPlaceSaver();
}

@Riverpod(keepAlive: true)
Picker picker(Ref ref) {
  return FilePickerPicker();
}
