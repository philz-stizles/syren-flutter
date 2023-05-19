import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/services/services.dart';
import 'package:syren/widgets/widgets.dart';
import 'package:syren/screens/views.dart';

class ForgotPasswordController extends GetxController {
  // Providers.
  var authServ = Get.find<AuthService>();

  // Form.
  final emailController = TextEditingController();

  // Observables.
  var isLoadingForgotPassword = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    try {
      final email = emailController.text.trim();
      isLoadingForgotPassword(true);
      await authServ.resetPassword(email: email);
      UIConfig.showSnackBar(
          message: 'Password reset was sent successfully',
          backgroundColor: Colors.green);
      Get.offAllNamed(SignInView.routeName,
            arguments: {'email': email});
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
