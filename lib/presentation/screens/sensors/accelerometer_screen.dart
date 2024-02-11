import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/accelerometer_provider.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometerXYZ = ref.watch(accelerometerProvider);
    final userAccelerometerXYZ = ref.watch(userAccelerometerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          accelerometerXYZ.when(
            data: (v) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Acelerómetro', style: TextStyle(fontSize: 20)),
                Text('x: ${v.x.toStringAsFixed(2)}'),
                const SizedBox(height: 20),
                Text('y: ${v.y.toStringAsFixed(2)}'),
                const SizedBox(height: 20),
                Text('z: ${v.z.toStringAsFixed(2)}'),
                const SizedBox(height: 20),
                Text('Acelerómetro Usuario', style: TextStyle(fontSize: 20)),
                userAccelerometerXYZ.when(
                  data: (v) => Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('x: ${v.x.toStringAsFixed(2)}'),
                      const SizedBox(height: 20),
                      Text('y: ${v.y.toStringAsFixed(2)}'),
                      const SizedBox(height: 20),
                      Text('z: ${v.z.toStringAsFixed(2)}'),
                    ],
                  ),
                  error: (error, stack) => Text('Error: $error'),
                  loading: () => CircularProgressIndicator(),
                ),
              ],
            ),
            error: (error, stack) => Text('Error: $error'),
            loading: () => CircularProgressIndicator(),
          )
        ],
      )),
    );
  }
}
