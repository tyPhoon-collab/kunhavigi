import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunhavigi_shared/src/entry.dart';

part 'search_query.freezed.dart';
part 'search_query.g.dart';

@freezed
sealed class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    required String query,
    @RelativePathConverter() RelativePath? path,
    @Default(10) int limit,
    @Default(0) int offset,
  }) = _SearchQuery;

  factory SearchQuery.fromJson(Map<String, Object?> json) =>
      _$SearchQueryFromJson(json);

  const SearchQuery._();

  int get page => offset ~/ limit + 1;

  SearchQuery nextPage() {
    return copyWith(offset: offset + limit);
  }

  SearchQuery previousPage() {
    return copyWith(offset: (offset - limit).clamp(0, offset));
  }
}
