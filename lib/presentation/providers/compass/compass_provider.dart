import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CompassProvider = StreamProvider<double?>((ref) async* {
  if (FlutterCompass.events == null) {
    throw Exception('FlutterCompass is not available on this device');
  }

  try {
    await for (final event in FlutterCompass.events!) {
      yield event.heading;
    }
  } catch (e) {
    print('Error getting heading: $e');
  }
});
