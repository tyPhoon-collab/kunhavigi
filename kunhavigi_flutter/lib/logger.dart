import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    excludeBox: {
      Level.trace: true,
      Level.debug: true,
    },
  ),
);

/// Log information message
void logInfo(String message, [Object? extra]) {
  if (kDebugMode) {
    logger.i(message, error: extra);
  }
}

/// Log warning message
void logWarning(String message, [Object? extra]) {
  if (kDebugMode) {
    logger.w(message, error: extra);
  }
}

/// Log error with optional stack trace
void logError(String message, Object? error, [StackTrace? stackTrace]) {
  if (kDebugMode) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }
}

/// Log debug message
void logDebug(String message, [Object? extra]) {
  if (kDebugMode) {
    logger.d(message, error: extra);
  }
}
