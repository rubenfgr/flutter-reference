import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeXYZ {
  final double x;
  final double y;
  final double z;

  const GyroscopeXYZ({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() {
    return 'GyroscopeXYZ(x: $x, y: $y, z: $z)';
  }
}

final gyroscopeProvider = StreamProvider<GyroscopeXYZ>((ref) async* {
  await for (final e in gyroscopeEventStream()) {
    yield GyroscopeXYZ(
      x: double.parse(e.x.toStringAsFixed(2)),
      y: double.parse(e.y.toStringAsFixed(2)),
      z: double.parse(e.z.toStringAsFixed(2)),
    );
  }
});
