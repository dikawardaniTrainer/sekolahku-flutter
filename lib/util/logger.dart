import 'package:flutter/foundation.dart';

void debug(Object message) {
  if (kDebugMode) {
    print("================START====================");
    print(message);
    print("=================END=====================");
  }
}

void debugError(error, stackTrace) {
  debug("$error\n$stackTrace");
}

void debugAction(String action, Object message) {
  debug("""
Action => $action
$message""");
}