import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      print('akxljj${await _auth.canCheckBiometrics}');
      return await _auth.canCheckBiometrics;

    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    print("isAvailable:$isAvailable");
    if (!isAvailable) return false;

    try {
      print('lksflodsjkfo;s,dfl');

      return await _auth.authenticateWithBiometrics(
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );

    } on PlatformException catch (e) {
      print('lksflodsjkfo;s,dfl catch   ${e.message}');

      return false;
    }
  }
}