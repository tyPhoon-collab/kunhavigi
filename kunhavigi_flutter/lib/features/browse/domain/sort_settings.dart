import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunhavigi_client/kunhavigi_client.dart';

part 'sort_settings.freezed.dart';

enum SortType {
  name(
    'Name',
    Icons.text_fields,
  ),
  type(
    'Type',
    Icons.category,
  ),
  size(
    'Size',
    Icons.storage,
  ),
  lastModified(
    'Last Modified',
    Icons.schedule,
  );

  const SortType(
    this.label,
    this.icon,
  );

  final String label;
  final IconData icon;
}

enum SortOrder {
  ascending,
  descending,
}

@freezed
sealed class SortSettings with _$SortSettings {
  const factory SortSettings({
    @Default(SortType.name) SortType type,
    @Default(SortOrder.ascending) SortOrder order,
  }) = _SortSettings;

  const SortSettings._();

  SortSettings toggleOrder() {
    return copyWith(
      order: order == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending,
    );
  }

  List<Entry> sort(List<Entry> entries) {
    final sorted = List<Entry>.from(entries)
      ..sort((a, b) {
        final result = switch (type) {
          SortType.name => _compareByName(a, b),
          SortType.type => _compareByType(a, b),
          SortType.size => _compareBySize(a, b),
          SortType.lastModified => _compareByLastModified(a, b),
        };

        return order == SortOrder.ascending ? result : -result;
      });

    return sorted;
  }

  int _compareByName(Entry a, Entry b) =>
      a.name.toLowerCase().compareTo(b.name.toLowerCase());

  int _compareByLastModified(Entry a, Entry b) =>
      a.lastModifiedAt.compareTo(b.lastModifiedAt);

  int _compareByType(Entry a, Entry b) {
    final dirOrder = _compareDirectoryFirst(a, b);
    if (dirOrder != null) return dirOrder;

    return switch ((a, b)) {
      (final FileEntry aFile, final FileEntry bFile) =>
        aFile.mimeType.compareTo(bFile.mimeType),
      _ => _compareByName(a, b),
    };
  }

  int _compareBySize(Entry a, Entry b) {
    final dirOrder = _compareDirectoryFirst(a, b);
    if (dirOrder != null) return dirOrder;

    return switch ((a, b)) {
      (final FileEntry aFile, final FileEntry bFile) =>
        aFile.size.compareTo(bFile.size),
      _ => _compareByName(a, b),
    };
  }

  int? _compareDirectoryFirst(Entry a, Entry b) {
    return switch ((a, b)) {
      (DirectoryEntry _, final Entry b) when b is! DirectoryEntry => -1,
      (final Entry a, DirectoryEntry _) when a is! DirectoryEntry => 1,
      _ => null,
    };
  }
}
