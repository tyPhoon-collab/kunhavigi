import 'package:flutter/material.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:toastification/toastification.dart';

class Teller {
  const Teller(this._context);
  final BuildContext _context;

  String error(String message) => _show(
        message: 'Error: $message',
        type: ToastificationType.error,
        autoCloseDurationSeconds: 7,
      ).id;

  String errorOf(Object error) {
    logger.e('Error was displayed', error: error);

    return _show(
      message: 'Error: $error',
      type: ToastificationType.error,
      autoCloseDurationSeconds: 7,
    ).id;
  }

  String info(String message) => _show(
        message: message,
        type: ToastificationType.info,
        autoCloseDurationSeconds: 3,
      ).id;

  String success(String message) => _show(
        message: message,
        type: ToastificationType.success,
      ).id;

  void progress(
    String message,
    Stream<Progress> progress, {
    VoidCallback? onSuccess,
    void Function(Object error)? onError,
  }) {
    late String itemId;
    final item = _show(
      message: message,
      description: _Tracker(
        progress: progress,
        onDismiss: () => dismiss(itemId),
        onSuccess: onSuccess,
        onError: onError,
      ),
      type: ToastificationType.info,
    );

    itemId = item.id;
  }

  ToastificationItem _show({
    required String message,
    required ToastificationType type,
    Widget? description,
    int? autoCloseDurationSeconds,
  }) {
    final colorScheme = Theme.of(_context).colorScheme;

    final (foregroundColor, backgroundColor) = switch (type) {
      ToastificationType.error => (
          colorScheme.onErrorContainer,
          colorScheme.errorContainer
        ),
      _ => (colorScheme.onSurface, colorScheme.surfaceBright),
    };

    return toastification.show(
      context: _context,
      title: Text(message),
      description: description,
      type: type,
      autoCloseDuration: Duration(seconds: autoCloseDurationSeconds ?? 5),
      alignment: AlignmentDirectional.bottomStart,
      showIcon: false,
      backgroundColor: backgroundColor.withValues(alpha: 0.9),
      foregroundColor: foregroundColor,
      borderSide: const BorderSide(style: BorderStyle.none),
      margin: const EdgeInsets.only(left: 16, bottom: 4),
    );
  }

  void dismiss(String id) => toastification.dismissById(id);
}

class Progress {
  const Progress({
    required this.current,
    required this.total,
    required this.isComplete,
  });

  final int current;
  final int total;
  final bool isComplete;

  double get value => total > 0 ? current / total : 0.0;

  @override
  String toString() =>
      'Progress(current: $current, total: $total, isComplete: $isComplete)';
}

class _Tracker extends StatelessWidget {
  const _Tracker({
    required this.progress,
    required this.onDismiss,
    this.onSuccess,
    this.onError,
  });

  final Stream<Progress> progress;
  final VoidCallback onDismiss;
  final VoidCallback? onSuccess;
  final void Function(Object error)? onError;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Progress>(
      stream: progress,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;

          if (data.isComplete) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onSuccess?.call();
              onDismiss();
            });
          }

          return LinearProgressIndicator(
            value: data.value,
            semanticsLabel: 'Progress: ${data.current} of ${data.total}',
            semanticsValue: '${data.current} of ${data.total}',
          );
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onError?.call(snapshot.error!);
            onDismiss();
          });
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
