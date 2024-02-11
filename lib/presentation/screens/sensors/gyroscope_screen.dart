import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miscelaneos/presentation/providers/sensors/gyroscope_provider.dart';

class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscopeXYZ$ = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giróscopio'),
      ),
      body: Center(
          child: gyroscopeXYZ$.when(
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
