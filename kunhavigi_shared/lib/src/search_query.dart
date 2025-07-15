// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunhavigi_shared/src/entry.dart';

part 'search_query.freezed.dart';
part 'search_query.g.dart';

@freezed
sealed class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    required String query,
    @RelativePathConverter() RelativePath? path,
    @Default(50) int limit,
    @Default(0) int offset,
  }) = _SearchQuery;

  factory SearchQuery.fromJson(Map<String, Object?> json) =>
      _$SearchQueryFromJson(json);
}
