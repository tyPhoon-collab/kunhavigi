import 'package:flutter/material.dart';
import 'package:kunhavigi_flutter/logger.dart';
import 'package:toastification/toastification.dart';

const AlignmentDirectional _alignment = AlignmentDirectional.bottomStart;

class Teller {
  const Teller(this._context);

  final BuildContext _context;

  String error(String message) => toastification
      .show(
        context: _context,
        title: Text('Error: $message'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 7),
        alignment: _alignment,
      )
      .id;

  String errorOf(Object error) {
    logger.e('Error was displayed', error: error);

    return toastification
        .show(
          context: _context,
          title: Text('Error: $error'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 7),
          alignment: _alignment,
        )
        .id;
  }

  String info(String message) => toastification
      .show(
        context: _context,
        title: Text(message),
        type: ToastificationType.info,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: _alignment,
      )
      .id;

  String success(String message) => toastification
      .show(
        context: _context,
        title: Text(message),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: _alignment,
      )
      .id;

  void progress(
    String message,
    Stream<Progress> progress, {
    VoidCallback? onSuccess,
    void Function(Object error)? onError,
  }) {
    late String itemId;
    final item = toastification.show(
      context: _context,
      title: Text(message),
      description: _Tracker(
        progress: progress,
        onDismiss: () => dismiss(itemId),
        onSuccess: onSuccess,
        onError: onError,
      ),
      type: ToastificationType.info,
      alignment: _alignment,
    );

    itemId = item.id;
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
