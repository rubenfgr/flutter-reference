import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miscelaneos/presentation/providers/sensors/magnetometer_provider.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometerXYZ$ = ref.watch(magnetometerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetómetro'),
      ),
      body: Center(
          child: magnetometerXYZ$.when(
        data: (v) => Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x: ${v.x.toStringAsFixed(2)}',
                style: GoogleFonts.robotoCondensed(fontSize: 20)),
            const SizedBox(height: 20),
            Text('y: ${v.y.toStringAsFixed(2)}',
                style: GoogleFonts.robotoCondensed(fontSize: 20)),
            const SizedBox(height: 20),
            Text('z: ${v.z.toStringAsFixed(2)}',
                style: GoogleFonts.robotoCondensed(fontSize: 20)),
          ],
        ),
        error: (error, stack) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      )),
    );
  }
}
