import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricsScreen extends ConsumerWidget {
  const BiometricsScreen({super.key});

  @override
  Widget build(BuildContext contex, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometricos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton.tonal(
                onPressed: () {
                  ref.read(localAuthProvider.notifier).authenticateUser();
                },
                child: Text('Autenticar')),
            SizedBox(height: 20),
            canCheckBiometrics.when(
              data: (value) =>
                  Text('Puede comprobar biométricos: ${value ? 'Si' : 'No'}'),
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text('Error: $e'),
            ),
            SizedBox(height: 20),
            const Text('Estado del biométrico', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Estado: '),
                Text(
                  getStatusLabel(localAuthState.status),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getStatusLabel(LocalAuthStatus status) {
    switch (status) {
      case LocalAuthStatus.authenticated:
        return 'Autenticado';
      case LocalAuthStatus.notAuthenticated:
        return 'No autenticado';
      case LocalAuthStatus.authenticating:
        return 'Autenticando...';
      default:
        return '';
    }
  }
}
