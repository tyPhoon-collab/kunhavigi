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
