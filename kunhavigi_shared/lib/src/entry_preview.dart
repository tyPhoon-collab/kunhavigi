import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_preview.freezed.dart';
part 'entry_preview.g.dart';

@freezed
sealed class EntryPreview with _$EntryPreview {
  const factory EntryPreview.text({required String text}) = TextEntryPreview;
  const factory EntryPreview.image({
    @BytesToBase64Converter() required Uint8List base64,
  }) = ImageEntryPreview;
  const factory EntryPreview.unknown() = UnknownEntryPreview;

  factory EntryPreview.fromJson(Map<String, Object?> json) =>
      _$EntryPreviewFromJson(json);
}

class BytesToBase64Converter implements JsonConverter<Uint8List, String> {
  const BytesToBase64Converter();

  @override
  Uint8List fromJson(String json) {
    return Uint8List.fromList(base64Decode(json));
  }

  @override
  String toJson(Uint8List object) {
    return base64Encode(object);
  }
}
