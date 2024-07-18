import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/location/watch_location_provider.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Controlled Map'),
        ),
        body: watchLocationAsync.when(
          data: (location) => MapAndControls(
            latitude: location.$1,
            longitude: location.$2,
          ),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ));
  }
}

class MapAndControls extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
