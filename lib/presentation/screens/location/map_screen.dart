import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/location/watch_location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: watchLocationAsync.when(
          data: (data) =>
              _MapView(initialLatitude: data.$1, initialLongitude: data.$2),
          error: (e, st) => Text('Error: $e'),
          loading: () => const CircularProgressIndicator()),
    );
  }
}

class _MapView extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const _MapView(
      {super.key,
      required this.initialLatitude,
      required this.initialLongitude});

  @override
  State<_MapView> createState() => __MapViewState();
}

class __MapViewState extends State<_MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.satellite,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLatitude, widget.initialLongitude),
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
