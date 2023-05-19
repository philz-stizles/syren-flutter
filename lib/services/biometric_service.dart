import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syren/screens/auth/signin/signin_controller.dart';
import 'package:syren/services/services.dart';
import 'package:syren/utils/security.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricService extends GetxService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final RxBool canCheckBiometric = false.obs;
  final RxBool hasFingerPrintLock = false.obs;
  final RxBool hasFaceLock = false.obs;
  final RxBool isUserAuthenticated = false.obs;
  final RxBool isDeviceSupported = false.obs;
  final RxList<BiometricType> availableBiometric = <BiometricType>[].obs;
  final _storage = GetStorage();
  final String fingerprintKey = LocalAuthEnum.isFingerprintEnabled.name;
  final String faceKey = LocalAuthEnum.isFaceEnabled.name;
  final String usernameKey = LocalAuthEnum.username.name;
  final String passKey = LocalAuthEnum.biometric.name;
  final RxBool isBiometricEnabled = false.obs;
  final RxBool isLoading = false.obs;

  final signInCtrl = Get.put(SignInController());
  final mainCtrl = Get.put(UserService());

  @override
  onInit() async {
    await _getAvailableBiometric();
    await init();
    super.onInit();
  }

  Future<void> init() async {
    var currentValue = _storage.read(fingerprintKey);
    if (currentValue != null && currentValue is bool) {
      isBiometricEnabled.value = currentValue;
    } else {
      isBiometricEnabled.value = false;
      await _storage.write(fingerprintKey, isBiometricEnabled.value);
    }
  }

  Future<void> toggleFingerprintEnabled() async {
    if (_storage.hasData(fingerprintKey) &&
        _storage.read(fingerprintKey) is bool) {
      var newValue = !_storage.read(fingerprintKey);
      isBiometricEnabled.value = newValue;
      await _storage.write(fingerprintKey, isBiometricEnabled.value);
    } else {
      isBiometricEnabled.value = false;
      await _storage.write(fingerprintKey, isBiometricEnabled.value);
    }
  }

  Future<void> enableFingerprint() async {
    isBiometricEnabled.value = true;
    await _storage.write(fingerprintKey, isBiometricEnabled.value);

    var email = mainCtrl.user!.email;
    if (email != null) {
      await _storage.write(usernameKey, Security.encrypt(email));
    }
  }

  Future<void> disableFingerprint() async {
    isBiometricEnabled.value = false;
    await _storage.write(fingerprintKey, isBiometricEnabled.value);
    await _storage.remove(usernameKey);
  }

  Map<String, dynamic> _getCredentials() {
    return {
      'username': Security.decrypt(_storage.read(usernameKey)),
      'pass': Security.decrypt(_storage.read(passKey))
    };
  }

  Future<void> toggleFaceEnabled() async {
    if (_storage.hasData(faceKey) && _storage.read(faceKey) is bool) {
      await _storage.write(faceKey, !_storage.read(faceKey));
    } else {}
  }

  bool isFingerprintEnabled() => getStatus(fingerprintKey);
  bool isFaceEnabled() => getStatus(faceKey);
  bool getStatus(String key) {
    var storeValue = _storage.read(key);
    return (storeValue != null && storeValue is bool) ? storeValue : false;
  }

  Future<void> _getAvailableBiometric() async {
    // Check whether there is local authentication available on ths device.
    canCheckBiometric.value = await _localAuth.canCheckBiometrics;
    isDeviceSupported.value = await _localAuth.isDeviceSupported();

    try {
      if (canCheckBiometric.value || isDeviceSupported.value) {
        availableBiometric.value = await _localAuth.getAvailableBiometrics();
        hasFaceLock.value = availableBiometric.contains(BiometricType.face);
        hasFingerPrintLock.value =
            availableBiometric.contains(BiometricType.fingerprint);
      } else {
        showSnackBar(
            message: 'Local Authentication  not available',
            backgroundColor: Colors.white);
      }
    } on PlatformException catch (e) {
      availableBiometric.value = <BiometricType>[];
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  Future<void> authenticatUser() async {
    try {
      isUserAuthenticated.value = await _localAuth.authenticate(
          localizedReason: "SCAN YOUR FINGER PRINT TO GET AUTHORIZED",
          options: const AuthenticationOptions(
              useErrorDialogs: true,
              biometricOnly: true,
              stickyAuth: false,
              sensitiveTransaction: true));

      if (isUserAuthenticated.value) {
        var credentials = _getCredentials();
        signInCtrl.signIn(
            email: credentials['username'], password: credentials['pass']);
        // showSnackBar(
        //     message: 'You\'re authentication was successful',
        //     backgroundColor: Colors.green,
        //     icon: const Icon(Icons.check));
      } else {
        showSnackBar(
            message: 'Authentication Cancelled',
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error_outline));
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        // ...
      } else {
        // ...
      }

      showSnackBar(message: e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> _cancelAuthentication() async {
    await _localAuth.stopAuthentication();
    isUserAuthenticated.value = false;
  }

  void showSnackBar({required String message, required backgroundColor, icon}) {
    Get.showSnackbar(GetSnackBar(
        // title: title,
        message: message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
        icon: icon,
        snackPosition: SnackPosition.BOTTOM));
  }
}

enum LocalAuthEnum { isFingerprintEnabled, isFaceEnabled, username, biometric }
