import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerXYZ {
  final double x;
  final double y;
  final double z;

  const MagnetometerXYZ({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() {
    return 'MagnetometerGyroscopeXYZ(x: $x, y: $y, z: $z)';
  }
}

final magnetometerProvider = StreamProvider<MagnetometerXYZ>((ref) async* {
  await for (final e in magnetometerEventStream()) {
    yield MagnetometerXYZ(
      x: double.parse(e.x.toStringAsFixed(2)),
      y: double.parse(e.y.toStringAsFixed(2)),
      z: double.parse(e.z.toStringAsFixed(2)),
    );
  }
});
