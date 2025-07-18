import 'package:flutter/material.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/button/icon_button.dart';
import 'package:kunhavigi_flutter/features/browse/presentation/path_breadcrumb.dart';

const _mobileWidthThreshold = 600;

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = theme.scaffoldBackgroundColor;
    final foregroundColor = colorScheme.onSurface.withValues(alpha: 0.8);

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IconTheme.merge(
        data: IconThemeData(color: foregroundColor),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: foregroundColor),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < _mobileWidthThreshold;
              return _HeaderContent(isMobile: isMobile);
            },
          ),
        ),
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: [PathBreadcrumb(), _Tools(isExpanded: true)],
      );
    }
    return const Row(
      spacing: 4,
      children: [Expanded(child: PathBreadcrumb()), _Tools(isExpanded: false)],
    );
  }
}

class _Tools extends StatelessWidget {
  const _Tools({required this.isExpanded});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    const children = [
      SearchIconButton(),
      SortIconButton(),
      SortOrderIconButton(),
      ReloadIconButton(),
      SettingsIconButton(),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: isExpanded
          ? children.map((e) => Expanded(child: e)).toList()
          : children,
    );
  }
}
