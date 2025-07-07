import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';
import 'package:kunhavigi_flutter/browse/provider/entry_provider.dart';
import 'package:kunhavigi_flutter/browse/provider/service_provider.dart';
import 'package:kunhavigi_flutter/client.dart';

class Browser {
  const Browser(this.ref);

  final Ref ref;

  Client get _client => ref.read(clientProvider);

  Future<void> rename(RelativePath path, String newName) async {
    final _ = await _client.browse.rename(
      path: path,
      newName: newName,
    );

    ref.invalidate(entriesProvider(path.parent));
  }

  Future<void> delete(RelativePath path) async {
    await _client.browse.delete(path);
    ref.invalidate(entriesProvider(path.parent));
  }

  Future<void> download(FileEntry entry) async {
    final bytes = await _client.transfer.downloadFile(entry.path);
    await ref.read(saverProvider).save(
          bytes,
          name: entry.name,
          mimeType: entry.mimeType,
        );
  }
}
