import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/permissions/permissions_provider.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso requerido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Localización necesaria'),
            ElevatedButton(
              onPressed: () {
                ref.read(permissionProvider.notifier).requestLocationAccess();
              },
              child: const Text('Solicitar permiso'),
            ),
          ],
        ),
      ),
    );
  }
}
