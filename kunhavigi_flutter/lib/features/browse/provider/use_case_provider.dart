import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunhavigi_flutter/features/browse/application/use_case.dart';
import 'package:kunhavigi_flutter/features/browse/provider/service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_case_provider.g.dart';

@Riverpod(keepAlive: true)
RenameUseCase renameUseCase(Ref ref) {
  return RenameUseCase(ref);
}

@Riverpod(keepAlive: true)
DeleteUseCase deleteUseCase(Ref ref) {
  return DeleteUseCase(ref);
}

@Riverpod(keepAlive: true)
DownloadUseCase downloadUseCase(Ref ref) {
  return DownloadUseCase(ref);
}

@Riverpod(keepAlive: true)
UploadUseCase uploadUseCase(Ref ref) {
  return UploadUseCase(ref);
}

@Riverpod(keepAlive: true)
DropAndUploadUseCase dropAndUploadUseCase(Ref ref) {
  return DropAndUploadUseCase(
    uploader: ref.read(uploadUseCaseProvider),
  );
}

@Riverpod(keepAlive: true)
PickAndUploadUseCase pickAndUploadUseCase(Ref ref) {
  return PickAndUploadUseCase(
    uploader: ref.read(uploadUseCaseProvider),
    picker: ref.read(pickerProvider),
  );
}
