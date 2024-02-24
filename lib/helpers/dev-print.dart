import 'package:flutter/foundation.dart';

devPrint(String message) {
  if (kDebugMode) {
    print(message);
  }
}
