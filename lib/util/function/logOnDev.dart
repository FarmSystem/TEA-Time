import 'package:flutter/foundation.dart';

void logOnDev(String message) {
  if (kDebugMode) {
    print(message);
  }
}