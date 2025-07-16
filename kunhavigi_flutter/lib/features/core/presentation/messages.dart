import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:kunhavigi_flutter/theme.dart';

class ErrorMessage extends HookWidget {
  const ErrorMessage({
    required this.error,
    this.stackTrace,
    super.key,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    useEffect(() {
      logger.e('ErrorMessage displayed', error: error, stackTrace: stackTrace);
      return null;
    }, [error, stackTrace]);

    return _MessageContainer(
      icon: Icons.error_outline,
      iconColor: colorScheme.onErrorContainer,
      backgroundColor: colorScheme.errorContainer,
      text: 'Error: $error',
      textColor: colorScheme.onErrorContainer,
    );
  }
}

class InfoMessage extends StatelessWidget {
  const InfoMessage({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _MessageContainer(
      icon: Icons.info_outline,
      iconColor: colorScheme.onSurface.withValues(alpha: 0.7),
      backgroundColor: colorScheme.surfaceContainerHigh,
      text: message,
      textColor: colorScheme.onSurface.withValues(alpha: 0.8),
    );
  }
}

class WarningMessage extends StatelessWidget {
  const WarningMessage({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _MessageContainer(
      icon: Icons.warning_amber_rounded,
      iconColor: colorScheme.onSecondaryContainer,
      backgroundColor: colorScheme.secondaryContainer,
      text: message,
      textColor: colorScheme.onSecondaryContainer.withValues(alpha: 0.9),
    );
  }
}

class _MessageContainer extends StatelessWidget {
  const _MessageContainer({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(color: backgroundColor, shape: shape),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
