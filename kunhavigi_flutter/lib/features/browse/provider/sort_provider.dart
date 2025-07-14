import 'package:kunhavigi_flutter/features/browse/domain/sort_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentSortSettings extends _$CurrentSortSettings {
  @override
  SortSettings build() {
    return const SortSettings();
  }

  void setSortType(SortType type) {
    if (state.type == type) {
      state = state.toggleOrder();
    } else {
      state = state.copyWith(type: type, order: SortOrder.ascending);
    }
  }

  void toggleOrder() {
    state = state.toggleOrder();
  }
}
