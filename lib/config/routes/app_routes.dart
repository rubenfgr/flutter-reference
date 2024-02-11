import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

final router = GoRouter(
    errorBuilder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: Center(
            child: Text('Ruta no encontrada: ${state.uri}'),
          ),
        ),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const PermissionsScreen(),
      ),
      GoRoute(
        path: '/gyroscope',
        builder: (context, state) => const GyroscopeScreen(),
      ),
      GoRoute(
        path: '/accelerometer',
        builder: (context, state) => const AccelerometerScreen(),
      ),
      GoRoute(
        path: '/magnetometer',
        builder: (context, state) => const MagnetometerScreen(),
      ),
      GoRoute(
        path: '/gyroscope-ball',
        builder: (context, state) => const GyroscopeBallScreen(),
      ),
      GoRoute(
        path: '/compass',
        builder: (context, state) => const CompassScreen(),
      ),
    ]);