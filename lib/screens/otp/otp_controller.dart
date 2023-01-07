import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class OtpController extends GetxController {
  // Data.
  dynamic argumentData = Get.arguments;

  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Form.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables.
  var isLoadingOtp = false.obs;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage
    emailController.text = argumentData != null && argumentData['email'] != null
        ? argumentData['email']
        : '';
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signIn() async {
    try {
      isLoadingOtp(true);
      await authProvider.signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingOtp(false);
    }
  }
}
