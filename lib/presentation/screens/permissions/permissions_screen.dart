import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: const _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          title: const Text('Cámara'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (v) {
            ref.read(permissionProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photoLibraryGranted,
          title: const Text('Librería de fotos'),
          subtitle: Text('${permissions.photoLibrary}'),
          onChanged: (v) {
            ref.read(permissionProvider.notifier).requestPhotoLibraryAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          title: const Text('Sensores'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (v) {
            ref.read(permissionProvider.notifier).requestSensorsAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          title: const Text('Ubicación'),
          subtitle: Text('${permissions.location}'),
          onChanged: (v) {
            ref.read(permissionProvider.notifier).requestLocationAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationAlwaysGranted,
          title: const Text('Ubicación siempre'),
          subtitle: Text('${permissions.locationAlways}'),
          onChanged: (v) {
            ref.read(permissionProvider.notifier).requestLocationAlwaysAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationWhenInUseGranted,
          title: const Text('Ubicación cuando se usa'),
          subtitle: Text('${permissions.locationWhenInUse}'),
          onChanged: (v) {
            ref
                .read(permissionProvider.notifier)
                .requestLocationWhenInUseAccess();
          },
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
              onPressed: () => openAppSettings(),
              child: const Text('Abrir configuración')),
        ),
      ],
    );
  }
}
