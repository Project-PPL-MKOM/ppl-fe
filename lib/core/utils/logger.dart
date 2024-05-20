import 'dart:developer';

import 'package:logging/logging.dart';

abstract class AppLogger {
  static void setup() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.time}: ${record.message} - ${record.error}');
    });
  }
}
