import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:miscelaneos/helpers/dev-print.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    devPrint('LocalAuthPlugin.availableBiometrics()');

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    devPrint(availableBiometrics.toString());
    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
      devPrint(availableBiometrics.toString());
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
      if (kDebugMode) {
        print('Biometrics are available');
      }
    }
  }

  static Future<bool> canCheckBiometrics() async {
    devPrint('LocalAuthPlugin.canCheckBiometrics()');

    bool canCheckBiometrics = false;

    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (kDebugMode) {
      print('canCheckBiometrics: $canCheckBiometrics');
    }

    return canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    devPrint('LocalAuthPlugin.authenticate()');

    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(useErrorDialogs: false));
      devPrint('didAuthenticate: $didAuthenticate');
      return (
        didAuthenticate,
        didAuthenticate ? 'Autenticado' : 'No autenticado'
      );
    } on PlatformException catch (e) {
      String message = 'Error desconocido';
      if (e.code == auth_error.notAvailable) {
        devPrint('Biometricos no disponibles');
        message = 'Biometricos no disponibles';
      }
      if (e.code == auth_error.notEnrolled) {
        devPrint('Biometricos no configurados');
        message = 'Biometricos no configurados';
      }
      if (e.code == auth_error.lockedOut) {
        devPrint('Biometricos bloqueados');
        message = 'Biometricos bloqueados';
      }
      if (e.code == auth_error.passcodeNotSet) {
        devPrint('Contraseña no configurada');
        message = 'Contraseña no configurada';
      }
      if (e.code == auth_error.otherOperatingSystem) {
        devPrint('Sistema operativo no compatible');
        message = 'Sistema operativo no compatible';
      }
      if (e.code == auth_error.permanentlyLockedOut) {
        devPrint('Biometricos bloqueados permanentemente');
        message = 'Biometricos bloqueados permanentemente';
      }
      return (false, message);
    }
  }
}
