import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/providers/auth_provider.dart';
import 'package:syren/widgets/widgets.dart';

class ForgotPasswordController extends GetxController {
  // Providers.
  var authProvider = Get.put(AuthProvider());

  // Form.
  final emailController = TextEditingController();

  // Observables.
  var isLoadingForgotPassword = false.obs;

  @override
  void onInit() {
    // Simulating obtaining the user name from some local storage
    emailController.text = 'foo@foo.com';
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    try {
      isLoadingForgotPassword(true);
      await authProvider.resetPassword(email: emailController.text.trim());
      UIConfig.showSnackBar(
          message: 'Password reset was sent successfully',
          backgroundColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      if (e.message != null) {
        UIConfig.showSnackBar(
            message: e.message as String, backgroundColor: Colors.red);
      }
    } finally {
      isLoadingForgotPassword(false);
    }
  }
}

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
