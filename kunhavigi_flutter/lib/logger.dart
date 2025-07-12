import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: null,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    excludeBox: {
      Level.trace: true,
      Level.debug: true,
    },
  ),
);
