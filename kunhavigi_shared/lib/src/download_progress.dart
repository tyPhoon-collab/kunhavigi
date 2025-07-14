import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_progress.freezed.dart';
part 'download_progress.g.dart';

@freezed
sealed class DownloadProgress with _$DownloadProgress {
  const factory DownloadProgress.coping() = CopingDownloadProgress;

  const factory DownloadProgress.zipping() = ZippingDownloadProgress;

  const factory DownloadProgress.completed({required String downloadUrl}) =
      CompletedDownloadProgress;

  factory DownloadProgress.fromJson(Map<String, Object?> json) =>
      _$DownloadProgressFromJson(json);
}
