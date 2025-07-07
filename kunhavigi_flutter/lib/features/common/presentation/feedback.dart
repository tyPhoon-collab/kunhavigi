import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

const AlignmentDirectional _alignment = AlignmentDirectional.bottomStart;

void feedbackError(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: Text('Error: $message'),
    type: ToastificationType.error,
    autoCloseDuration: const Duration(seconds: 7),
    alignment: _alignment,
  );
}

void feedbackSuccess(BuildContext context, String message) {
  toastification.show(
    context: context,
    title: Text(message),
    type: ToastificationType.success,
    autoCloseDuration: const Duration(seconds: 5),
    alignment: _alignment,
  );
}
