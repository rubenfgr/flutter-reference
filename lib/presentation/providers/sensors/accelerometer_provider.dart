import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerXYZ {
  final double x;
  final double y;
  final double z;

  const AccelerometerXYZ({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() {
    return 'AccelerometerXYZ(x: $x, y: $y, z: $z)';
  }
}

final accelerometerProvider = StreamProvider<AccelerometerXYZ>((ref) async* {
  await for (final e in accelerometerEventStream()) {
    yield AccelerometerXYZ(
      x: double.parse(e.x.toStringAsFixed(2)),
      y: double.parse(e.y.toStringAsFixed(2)),
      z: double.parse(e.z.toStringAsFixed(2)),
    );
  }
});

final userAccelerometerProvider =
    StreamProvider<AccelerometerXYZ>((ref) async* {
  await for (final e in userAccelerometerEventStream()) {
    yield AccelerometerXYZ(
      x: double.parse(e.x.toStringAsFixed(2)),
      y: double.parse(e.y.toStringAsFixed(2)),
      z: double.parse(e.z.toStringAsFixed(2)),
    );
  }
});
