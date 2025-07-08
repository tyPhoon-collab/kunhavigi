import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

const AlignmentDirectional _alignment = AlignmentDirectional.bottomStart;

class Teller {
  const Teller(this._context);

  final BuildContext _context;

  void error(String message) {
    toastification.show(
      context: _context,
      title: Text('Error: $message'),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 7),
      alignment: _alignment,
    );
  }

  void success(String message) {
    toastification.show(
      context: _context,
      title: Text(message),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: _alignment,
    );
  }

  String progress(
    String message,
    Stream<Progress> progress,
  ) {
    final item = toastification.show(
      context: _context,
      title: Text(message),
      description: _Tracker(progress: progress),
      type: ToastificationType.info,
      alignment: _alignment,
    );

    return item.id;
  }

  void dismiss(String id) {
    toastification.dismissById(id);
  }
}

class Progress {
  const Progress({
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  double get value => total > 0 ? current / total : 0.0;

  @override
  String toString() => 'Progress(current: $current, total: $total)';
}

class _Tracker extends StatelessWidget {
  const _Tracker({
    required this.progress,
  });

  final Stream<Progress> progress;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Progress>(
      stream: progress,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return LinearProgressIndicator(
            value: data.value,
            semanticsLabel: 'Progress: ${data.current} of ${data.total}',
            semanticsValue: '${data.current} of ${data.total}',
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
