import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/compass/compass_provider.dart';
import 'package:miscelaneos/presentation/providers/permissions/permissions_provider.dart';
import 'package:miscelaneos/presentation/screens/permissions/ask_location_screen.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionProvider).locationGranted;

    if (!locationGranted) {
      return const AskLocationScreen();
    }

    final compassHeading$ = ref.watch(CompassProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Brújula', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: compassHeading$.when(
              data: (heading) => Compass(heading?.round() ?? 0),
              error: (e, s) => Text('Error: $e'),
              loading: () => const CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class Compass extends StatelessWidget {
  final int heading;
  const Compass(this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$heading°', style: TextStyle(fontSize: 30, color: Colors.white)),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/quadrant-1.png'),
            Transform.rotate(
                angle: -heading * (math.pi / 180),
                child: Image.asset('assets/images/needle-1.png')),
          ],
        ),
      ],
    );
  }
}
